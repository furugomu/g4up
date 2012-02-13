#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

class Idol
  attr_reader :name, :production, :gender, :romaji
  cattr_reader :idols

  def initialize(name, hash={})
    @name = name
    @production = hash[:production] || 765
    @gender = hash[:production] || :female
    @romaji = hash[:romaji]
    @age = hash[:age]
  end

  @@idols = [
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
  ]
end
