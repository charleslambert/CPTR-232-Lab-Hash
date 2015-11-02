#!/usr/bin/env ruby

require_relative "LinkedList.rb"

class MyHash
	attr_reader :hashA
	def initialize(p, w, a)
		@p = p
		@w = w
		@a = a
		@m = 2**p
		@s = @a * 2**@w
		@hashA = Array.new(@m) {LinkedList.new(nil)}
	end

	def hashFunc(key)
		h = ((2**@p*((key*@s) % 2**@w))/2**@w).floor
		return h
	end

	def insert(key,val)
		@hashA[hashFunc(key)].insert(key,val)
	end

	def delete(key)
		@hashA[hashFunc(key)].delete(key)
	end

	def search(key)
		return @hashA[hashFunc(key)].search(key)
	end

	def hashArray
		array = []
		@hashA.each { |i| array.push(i.count)}

		return array
	end
end

