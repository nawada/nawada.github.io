puts 'Title?'
title = nil
while title.nil? || title.empty?
  print '>> '
  title = gets.strip
end

puts  # 改行

categories = []
puts 'Category? (If you want to finish, input blank line)'
cat = nil
while cat != "\n"
  print '>> '
  cat = gets
  categories.push(cat.strip) if cat != "\n"
end

puts

puts <<-EOF
---
layout:     post
title:      "#{title}"
date:       #{Time.new}
categories: [#{categories.join(', ')}]
permalink:  "1"
---
  EOF