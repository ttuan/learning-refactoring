class Library
  attr_accessor :books, :members

  def initialize
    @books = []
    @members = []
  end

  def add_book(book)
    @books << book
  end

  def add_member(member)
    @members << member
  end

  def borrow_book(member_name, book_title)
    member = @members.find { |m| m.name == member_name }
    book = @books.find { |b| b.title == book_title }

    if member && book && book.available?
      member.borrowed_books << book
      book.status = 'unavailable'
    else
      raise 'Book cannot be borrowed'
    end
  end

  def return_book(member_name, book_title)
    member = @members.find { |m| m.name == member_name }
    book = member.borrowed_books.find { |b| b.title == book_title }

    if member && book
      member.borrowed_books.delete(book)
      book.status = 'available'
    else
      raise 'Book cannot be returned'
    end
  end
end

class Book
  attr_accessor :title, :author, :status

  def initialize(title, author)
    @title = title
    @author = author
    @status = 'available'
  end

  def available?
    @status == 'available'
  end
end

class Member
  attr_accessor :name, :borrowed_books

  def initialize(name)
    @name = name
    @borrowed_books = []
  end
end
