module Minesweeper
  class EmojiFactory
    def create_emoji(type)
      if type
        emoji = CatEmoji.new
      else
        emoji = BombEmoji.new
      end
      emoji
    end
  end
end
