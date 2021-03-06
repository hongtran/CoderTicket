require 'rails_helper'

RSpec.describe Event, type: :model do
	let(:event) {event = Event.new}
  describe "#venue_name" do
  	it "return nil if there is no venue" do
  		expect(event.venue_name).to be_nil
  	end

  	it "returns venue name if there is a event" do
  		event.venue = Venue.new(name: "RMIT")
  		expect(event.venue_name).to eq "RMIT"
  	end
  end

  describe "#feature_events" do
    it "Past events should not be shown"  do
       event1, event2 = Event.new(starts_at: 1.day.ago), Event.new(starts_at: DateTime.now + 5.days)
       event1.save! validate: false
       event2.save! validate: false 
       expect(Event.feature_events).to eq [event2]
     end
  end 

  describe "Event have at least one ticket type defined before it can be published" do
    it "Event dont have ticket type" do
      event.publish = true
      event.save! validate: false
      expect(event.make_publish).to eq nil
    end

    it "Event have more than 1 ticket type" do
      event.publish = false
      event.name = 'Việt Nam Thử Thách 2017' 
      event.starts_at = DateTime.parse('Fri, 20 Sep 2016 7:00 AM+0700')
      event.ends_at = DateTime.parse('Sun, 28 Sep 2016 3:00 PM+0700')
      event.venue = Venue.new(name: "RMIT")
      event.category = Category.new(name: 'category')
      event.user = User.find_by(email: 'user1@gmail.com')
      event.hero_image_url = 'https://az810747.vo.msecnd.net/eventcover/2015/10/25/C6A1A5.jpg?w=1040&maxheight=400&mode=crop&anchor=topcenter'
      event.extended_html_description = <<-DESC
    <p style="text-align:center"><span style="font-size:20px">VIỆT NAM THỬ THÁCH CHIẾN THẮNG 2016</span></p>
    <p style="text-align:center"><span style="font-size:20px">Giải đua xe đạp địa hình 11-13/03/2016</span></p>
    <p style="text-align:center"><span style="font-size:16px"><span style="font-family:arial,helvetica,sans-serif">Việt Nam Th</span>ử Thách Chiến Thắng là giải đua xe đạp địa hình được tổ chức như một sự tri ân, và cũng nhằm thỏa mãn lòng đam mẹ của những người yêu xe đạp địa hình nói chung, cũng như cho những ai đóng góp vào môn thể thao đua xe đạp tại thành phố Hồ Chí Minh. Cuộc đua diễn ra ở thành phố cao nguyên hùng vĩ Đà Lạt, với độ cao 1,500m (4,900ft) so với mặt nước biển. Đến với đường đua này ngoài việc tận hưởng cảnh quan nơi đây, bạn còn có cơ hội biết thêm về nền văn hóa của thành phố này. </span></p>
    <p style="text-align:center"><span style="font-size:16px">Hãy cùng với hơn 350 tay đua trải nghiệm 04 lộ trình đua tuyệt vời diễn ra trong 03 ngày tại Đà Lạt và bạn sẽ có những kỉ niệm không bao giờ quên!</span></p>
    <p style="text-align:center"><span style="font-size:16px">Để biết thêm thông tin chi tiết và tạo thêm hứng khởi cho cuộc đua 2016, vui lòng ghé thăm trang web</span></p>
    <p style="text-align:center"><span style="font-size:16px"><strong><span style="background-color:transparent; color:rgb(0, 0, 0)">www.vietnamvictorychallenge.com. </span></strong></span></p>
  DESC
      event.save!
      event.ticket_types.create! price: 1.00, max_quantity: 20
      expect(event.make_publish).to eq true 
    end
  end
end
