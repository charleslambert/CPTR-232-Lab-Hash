require_relative "MyHash.rb"
require_relative "LinkedList.rb"
require "test/unit"

class MyHashTest < Test::Unit::TestCase
	def setup
		MyHash.new(2,2,0.2)
	end

	def teardown
	end

end

class LinkedListTest < Test::Unit::TestCase
	def setup
		@ll = LinkedList.new(nil)
	end

	def teardown
	end

	def testSearch
		#test empty list
		assert_nil(@ll.search(10))
	end

	def testInsert
		@ll.insert(10,20)
		@ll.insert(5,309)
		assert_equal(20, @ll.search(10).value)
		assert_equal(309, @ll.search(5).value)
	end

	def testCount
		@ll.insert(10,20)
		@ll.insert(5,309)
		assert_equal(2,@ll.count)
	end

	def testDelete
		@ll.insert(10,20)
		@ll.insert(5,309)

		@ll.delete(10)
		assert_nil(@ll.search(10))

		@ll.delete(5)
		assert_nil(@ll.search(5))

		assert_equal(0,@ll.count)
	end
end