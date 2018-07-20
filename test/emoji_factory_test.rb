require "test_helper"

class EmojiFactoryTest < Minitest::Test
  def setup
    @emoji_factory = Minesweeper::EmojiFactory.new
  end

  def test_that_it_can_return_a_cat_emoji
    result = @emoji_factory.create_emoji(true)

    assert_instance_of(Minesweeper::CatEmoji, result)
  end

  def test_that_it_can_return_a_bomb_emoji
    result = @emoji_factory.create_emoji(nil)

    assert_instance_of(Minesweeper::BombEmoji, result)
  end
end