require "rubygems"
require "json"
require "net/http"
require "uri"


class HomeController < ApplicationController
    def hello
        encoded_url = URI.encode("http://data.consumerfinance.gov/resource/x94z-ydhh.json?$select=product, count(complaint_id) as count&$group=product")
        uri = URI.parse(encoded_url)

        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)

        response = http.request(request)

        @products = JSON.parse(response.body)
    end

    def result
        @state = params[:state]
        @product = params[:product]

        encoded_url = URI.encode("http://data.consumerfinance.gov/resource/x94z-ydhh.json?$where=state='" + @state + "' and product='" + @product + "'&$select=company, count(complaint_id) as count&$group=company&$order=count desc")
        uri = URI.parse(encoded_url)


        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)

        response = http.request(request)

        @companies = JSON.parse(response.body)


    end
end



