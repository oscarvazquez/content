json.subcategories @new_subs.each do |sub|
	json.category_id sub.category_id
	json.id sub.id
	json.subcategory sub.sub
end