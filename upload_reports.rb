#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'
require 'time'
require 'faraday'
require 'faraday/multipart'
require 'yaml'

program :name, 'upload_report'
program :version, '0.0.1'
program :description, 'CLI for uploading daily check reports to Flight Centre.'

command :upload_report do |c|
  c.syntax = 'simple upload_report [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.action do |args, options|
    if args.empty?
      say "No cluster specified."
    elsif args.length > 1
      say "Please only specify one cluster."
    else
      report = getReport(args[0])
      if report != 0
        uploadFile(report["file"], args[0], report["authToken"])
      else
        say "File does not exist - please ensure the cluster name is correct and the checks have been performed today."
      end
    end
  end
end

#grabs information from the YAML file and passes it back
def getReport(shorthand)
  components = YAML.load(File.read("components.yaml"))
  cluster = components[shorthand]["name"]
  auth = components[shorthand]["auth"]
  date = Time.new.strftime("%d-%m-%y").gsub('-','_')
  filepath = "exampleClusters/#{date} #{cluster} report.pdf"
  if File.file?(filepath)
    clusterInfo = {
      "file" => filepath,
      "authToken" => auth
    }
    return clusterInfo
  else
    return 0
  end
end

def uploadFile(report, cluster, authToken)
  
  content = Faraday::Multipart::FilePart.new(report, 'text/x-ruby')

  conn = Faraday.new(
    url: 'http://center.alces-flight.lvh.me:3000',
    headers: {
      'Content-Type' => 'multipart/form-data',
      'Accept' => 'application/json',
      'Authorization' => "Bearer #{authToken}"
    }
  )

  output = conn.post('/components/BAR/cluster_checks_reports/submit') do |out|
    out.body = {attachment: {data: content}, user: "Scott Mackenzie"}.to_json
  end

  puts output.body
end
