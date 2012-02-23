#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

class Idol
  attr_reader :name, :production, :gender, :romaji
  cattr_reader :all

  def initialize(name, hash={})
    @name = name
    @production = hash[:production] || 765
    @gender = hash[:production] || :female
    @romaji = hash[:romaji]
    @age = hash[:age]
  end

  @@all = [
    Idol.new('あずさ', age: 21, romaji: 'azusa'),
    Idol.new('亜美', age: 13, romaji: 'ami'),
    Idol.new('伊織', age: 15, romaji: 'iori'),
    Idol.new('貴音', age: 18, romaji: 'takane'),
    Idol.new('千早', age: 16, romaji: 'chihaya'),
    Idol.new('春香', age: 17, romaji: 'haruka'),
    Idol.new('響', age: 16, romaji: 'hibiki'),
    Idol.new('真', age: 17, romaji: 'makoto'),
    Idol.new('真美', age: 13, romaji: 'mami'),
    Idol.new('美希', age: 15, romaji: 'miki'),
    Idol.new('やよい', age: 14, romaji: 'yayoi'),
    Idol.new('雪歩', age: 17, romaji: 'yukiho'),
    Idol.new('律子', age: 19, romaji: 'ritsuko'),

    Idol.new('愛', production: 876, age: 13, romaji: 'ai'),
    #Idol.new('絵理', production: 876, age: 15, romaji: 'eri'),
    #Idol.new('涼', production: 876, age: 15, romaji: 'ryo'),

    #Idol.new('冬馬', production: 961, age: 17, romaji: 'touma'),
    #Idol.new('翔太', production: 961, age: 14, romaji: 'shota'),
    #Idol.new('北斗', production: 961, age: 20, romaji: 'hokuto'),
  ]

  class << self
    def names
      all.map(&:name)
    end

    def by_name(name)
      all.detect{|x|x.name==name}
    end
  end
end
