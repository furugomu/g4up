module ActsAsTaggableOn
  class Tag
    def to_param
      name
    end
  end
end
ActsAsTaggableOn::delimiter = ' '
