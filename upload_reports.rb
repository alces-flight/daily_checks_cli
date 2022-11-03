#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'
require 'time'
require 'faraday'
require 'yaml'

program :name, 'upload_report'
program :version, '0.0.1'
program :description, 'CLI for uploading daily check reports to Flight Centre.'

command :upload_report do |c|
  c.syntax = 'simple upload_report [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  # c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    if args.empty?
      say "No cluster specified."
    elsif args.length > 1
      say "Please only specify one cluster."
    else
      report = getReport(args[0])
      if report != 0
        uploadFile(report, args[0])
      else
        say "File does not exist - please ensure the cluster name is correct and the checks have been performed today."
      end
    end
  end
end

def getReport(shorthand)
  components = YAML.load(File.read("components.yaml"))
  cluster = components[shorthand]["name"]
  date = Time.new.strftime("%d-%m-%y").gsub('-','_')
  filepath = "exampleClusters/#{date} #{cluster} report.pdf"
  if File.file?(filepath)
    return filepath
  else
    return 0
  end
end

def uploadFile(report, cluster)
  conn = Faraday.new(
    url: 'https://jsonplaceholder.typicode.com',
    headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
      }
  )

  url = "/users/1/posts"
  body = {title: "#{cluster} report", body: "#{report}"}
  output = conn.post(url, body.to_json)

  puts output.body
end
