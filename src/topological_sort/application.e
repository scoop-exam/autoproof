note
	description: "topological_sort application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			topological: TOPOLOGICAL_SORT
			elements: LINKED_LIST[INTEGER]
			constraints: LINKED_LIST[TUPLE[INTEGER, INTEGER]]
			no_cycle: BOOLEAN
		do
			create elements.make
			create constraints.make
			elements.extend (1)
			elements.extend (2)
			elements.extend (3)
			elements.extend (4)
			elements.extend (5)

			constraints.extend ([1, 3])
			constraints.extend ([2, 3])
			constraints.extend ([3, 4])
			constraints.extend ([4, 5])
			-- constraints.extend ([5, 4])
			create topological.make(elements, constraints)
			no_cycle := topological.sort

			if no_cycle then
				io.put_string ("Sort completed%N")
			else
				io.put_string ("Cycle detected%N")
			end

			io.put_string ("Sorted:%N")
			across topological.sorted as s
			loop
			 io.put_string (s.item.out + "%N")
			end
			io.put_string ("%N")
		end
end
