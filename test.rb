# frozen_string_literal: true

require 'time'
require 'uri'
require 'net/http'

# speed data request function
def speed(label, color, speed)
  uri = URI("http://localhost:1988/plotter/#{label}/#{speed}/#{color}")
  Net::HTTP.get_response(uri)
end

# test data array
array = 10_000.times.map { rand }

# sum process by each
s = Process.clock_gettime(Process::CLOCK_MONOTONIC)

sum = 0
array.each { |x| sum += x }

e = Process.clock_gettime(Process::CLOCK_MONOTONIC)

speed('each', 'silver', s)
speed('each', 'silver', e)

# sum process by inject
s = Process.clock_gettime(Process::CLOCK_MONOTONIC)

sum = 0
sum = array.inject(&:+)

e = Process.clock_gettime(Process::CLOCK_MONOTONIC)

speed('inject', 'pink', s)
speed('inject', 'pink', e)

# sum process by sum function
s = Process.clock_gettime(Process::CLOCK_MONOTONIC)

sum = 0
sum = array.sum

e = Process.clock_gettime(Process::CLOCK_MONOTONIC)

speed('sum', 'blue', s)
speed('sum', 'blue', e)
