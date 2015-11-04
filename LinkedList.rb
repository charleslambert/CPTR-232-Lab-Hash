

class Node
	#implamentation of a linked list node
	attr_accessor :key, :value, :prev, :next
	
	def initialize(key, value)
		@key = key
		@value = value
	end
end

class LinkedList
	attr_reader :head, :tail

	def initialize(head)
		@head = head
		@tail = head
	end

	def insert(key,value)
		node = Node.new(key,value)

		if (@head == nil && @tail == nil)
		#adds a node if the list is empty
			@head = node
			@tail = node
		else
		#adds a node to a non-empty list
			@head.prev = node
			node.next = @head
			@head = node
		end 
	end

	def delete(key)
		node = self.search(key)

		if node
			if (node.next != nil)
				node.next.prev = node.prev
			elsif (node.prev != nil)
				node.prev.next = node.next
			else
				@head = nil
				@tail = nil
			end
		end

		return node
	end

	def count
	#count the number of elements in the list
		node = @head
		count = 0
		while(node != nil)
			node = node.next
			count = count + 1
		end

		return count
	end

	def search(key)
		node = @head
		while(node != nil && node.key != key)
			node = node.next
		end

		return node
	end
end