class Zotero::Entities::Creator 
  attr_reader :last_name, :first_name, :kind

  def initialize(data)
    @last_name = data['lastName']
    @first_name = data['firstName']
    @kind = data['creatorType']
  end

  def to_h
    {
      first_name: first_name,
      last_name: last_name,
      kind: kind
    }
  end
end
