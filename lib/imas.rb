# -*- encoding: UTF-8 -*-x
class Imas
  class << self
    def idol_names
      warn "Imas.idol_names is deprecated"
      Idol.names
    end
    def romaji(kana)
      warn "Imas.romaji is deprecated"
      Idol.by_name(kana).try(:romaji)
    end
  end
end
