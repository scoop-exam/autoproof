note
	description: "Summary description for {RELATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RELATION

create
	make

feature
	rel: MML_RELATION[INTEGER, INTEGER]
	note
		status: ghost
	attribute
	end

feature {NONE}
	rep:  V_HASH_SET[V_STRING]

	encode_couple(first, second: INTEGER): V_STRING do
		Result := create {V_STRING}.make_from_string (first.out + ":" + second.out)
	end

feature
	make
	note
		status: creator
	do
		create rel.default_create
		create rep.make (create {V_HASH_LOCK[V_STRING]})
	ensure
		not rel.is_empty
	end

feature
	in(first, second: INTEGER): BOOLEAN do
		Result := rep.has (encode_couple(first, second))
	ensure
		Result = rel.has (first, second)
	end

	is_empty: BOOLEAN do
		Result := rep.is_empty
	ensure
		Result = rel.is_empty
	end

	extend(first, second: INTEGER) do
		rep.extend (encode_couple(first, second))
		rel := rel.extended (first, second)
	ensure
		rel.has (first, second)
		-- not old rel.has (first, second) = (rel.count = old rel.count + 1)
		across old rel as pair all rel.has (pair.item.left, pair.item.right) end
		across rel as pair all (old rel).has (pair.item.left, pair.item.right)
			and not (pair.item.left = first and pair.item.right = second) end
	end

	remove(first, second: INTEGER) do
		rep.remove (encode_couple(first, second))
		rel := rel.removed (first, second)
	ensure
		not rel.has (first, second)
		rel.count = old rel.count + 1
		across old rel as pair all rel.has (pair.item.left, pair.item.right)  end
	end


	invariant
		rel /= Void and rep /= Void
end
