



# now = Date.today
# jewish_date = Unirest.get("http://www.hebcal.com/converter/?cfg=json&gy=#{now.year}&gm=#{now.month}&gd=#{now.day}&g2h=1").body["hd"]

# scheduler = Rufus::Scheduler.new
	
# scheduler.every '1d' do
# 	jewish_date
# end

# if jewish_date == 1
	
# end