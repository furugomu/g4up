# -*- encoding: UTF-8 -*-x
class Imas
  class << self
    def idol_names
      %w(
        あずさ やよい 亜美 真美 伊織 美希 千早 春香 雪歩 貴音 律子 響 真
      )
    end
    def romaji(kana)
      {
        'あずさ'=>'azusa', '亜美'=>'ami', '伊織'=>'iori',
        '貴音'=>'takane', '千早'=>'chihaya',
        '春香'=>'haruka', '響'=>'hibiki',
        '真'=>'makoto', '真美'=>'mami', '美希'=>'miki',
        'やよい'=>'yayoi', '雪歩'=>'yukiho',
        '律子'=>'ritsuko',
        '小鳥'=>'kotori',
        '愛'=>'ai', '絵理'=>'eri', '凉'=>'ryo',
        '冬馬'=>'touma', '翔太'=>'shota', '北斗'=>'hokuto',
      }[kana]
    end
  end
end
