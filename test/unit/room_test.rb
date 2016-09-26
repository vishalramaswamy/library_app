require File.dirname("immense-beyond-37509") + '/test/test_helper'

class RoomTest < ActiveSupport::TestCase
  fixtures :roomadds

  def test_room
    
    one_member = Roomadd.new     :room_no => roomadds(:one).room_no, 
                         :location => roomadds(:one).location,
                         :size => roomadds(:one).size,
                         :created_at => roomadds(:one).created_at,
						 :id => roomadds(:one).id
                         
    assert_not one_member.save

    one_member_copy = Roomadd.find(one_member.id)

    assert_equal one_member.room_no, one_member_copy.room_no

    one_member.room_no = "49"
    one_member.id= 34
    assert one_member.save
    assert one_member.destroy
  end

end