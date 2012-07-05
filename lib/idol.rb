#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

class Idol
  # TODO テーブルにしたほうが良いんじゃないですか

  attr_reader :name, :production, :gender, :age, :romaji, :kana

  def initialize(name, hash={})
    @name = name
    @production = hash[:production] || 765
    @gender = hash[:gender] || :female
    @romaji = hash[:romaji]
    @age = hash[:age]
    @kana = hash[:kana]
    @g4u = hash.has_key?(:g4u) ? hash[:g4u] : true
  end

  # G4U に出演している？
  def g4u?
    @g4u
  end

  @@all = [
    Idol.new('あずさ', age: 21, romaji: 'azusa', kana: 'あずさ'),
    Idol.new('亜美', age: 13, romaji: 'ami', kana: 'あみ'),
    Idol.new('伊織', age: 15, romaji: 'iori', kana: 'いおり'),
    Idol.new('貴音', age: 18, romaji: 'takane', kana: 'たかね'),
    Idol.new('千早', age: 16, romaji: 'chihaya', kana: 'ちはや'),
    Idol.new('春香', age: 17, romaji: 'haruka', kana: 'はるか'),
    Idol.new('響', age: 16, romaji: 'hibiki', kana: 'ひびき'),
    Idol.new('真', age: 17, romaji: 'makoto', kana: 'まこと'),
    Idol.new('真美', age: 13, romaji: 'mami', kana: 'まみ'),
    Idol.new('美希', age: 15, romaji: 'miki', kana: 'みき'),
    Idol.new('やよい', age: 14, romaji: 'yayoi', kana: 'やよい'),
    Idol.new('雪歩', age: 17, romaji: 'yukiho', kana: 'ゆきほ'),
    Idol.new('律子', age: 19, romaji: 'ritsuko', kana: 'りつこ'),

    Idol.new('愛', production: 876, age: 13, romaji: 'ai', kana: 'あい'),
    Idol.new('絵理', production: 876, age: 15, romaji: 'eri', kana: 'えり'),
    Idol.new('涼', production: 876, age: 15, romaji: 'ryo', kana: 'りょう'),

    Idol.new('冬馬', production: 961, gender: :male, age: 17,
             romaji: 'touma', kana: 'とうま', g4u: false),
    Idol.new('翔太', production: 961, gender: :male, age: 14,
             romaji: 'shota', kana: 'しょうた', g4u: false),
    Idol.new('北斗', production: 961, gender: :male, age: 20,
             romaji: 'hokuto', kana: 'ほくと', g4u: false),
  ]

  class << self
    def all
      @@all.select(&:g4u?)
    end

    def names
      all.map(&:name)
    end

    def by_name(name)
      all.detect{|x|x.name==name}
    end
  end
end
