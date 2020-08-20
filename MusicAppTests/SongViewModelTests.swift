//
//  SongViewModelTests.swift
//  MusicAppTests
//
//  Created by Joel on 8/20/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import XCTest
@testable import MusicApp

class SongViewModelTests: XCTestCase {
    var model: SongViewModel!

    override func setUpWithError() throws {
       
    }

    override func tearDownWithError() throws {
        model = nil
    }

    func testReleaseDateFormatFor2020()  {
        model = SongViewModel(song: self.mockSong())
        XCTAssertEqual(model.releaseDate, "Aug 7, 2020")
    }
    
    func testReleaseDateFormatIncorrect()  {
        let mockUnFormattedDate = mockSong(releaseDate: "2019/10/20")
        model = SongViewModel(song: mockUnFormattedDate)
        XCTAssertEqual(model.releaseDate, "Oct 20, 2019")
    }
    
    func testReleaseDateFormatInValid()  {
        let mockUnFormattedDate = mockSong(releaseDate: "20/05/2020")
        model = SongViewModel(song: mockUnFormattedDate)
        XCTAssertNotEqual(model.releaseDate, "May 20, 2020")
    }
    
    func testReleaseYearFormatYY()  {
        let mockUnFormattedDate = mockSong(releaseDate: "19/10/10")
        model = SongViewModel(song: mockUnFormattedDate)
        XCTAssertNotEqual(model.releaseDate, "Oct 10, 2019")
    }
    
    func testGenreString() {
        let genreValues = [Genre(name: "Rock"), Genre(name: "Country")]
       let mockGenreValues = mockSong(genres: genreValues)
        model = SongViewModel(song: mockGenreValues)
        XCTAssertEqual(model.genereLabel, "Rock, Country")
    }
    
    func testGenreStringWithOutSpace() {
        let genreValues = [Genre(name: "Rock"), Genre(name: "Country")]
       let mockGenreValues = mockSong(genres: genreValues)
        model = SongViewModel(song: mockGenreValues)
        XCTAssertNotEqual(model.genereLabel, "Rock,Country")
    }
    
    func testEmptyGenreString() {
        model = SongViewModel(song: self.mockSong())
        XCTAssertEqual(model.genereLabel, "")
    }

    private func mockSong(artistName: String = "Weekend",
                          releaseDate: String = "2020-08-07",
                          albumName: String = "Weekend",
                          copyright: String = "2020 all rights reserved",
                          albumImageUrl: String = "http://www.apple.com",
                          genres: [Genre] = [Genre](),
                          url: String = "") -> Album {
        return Album(artistName: artistName, releaseDate: releaseDate, albumName: albumName, copyright: copyright, albumImageUrl: albumImageUrl, genres: genres, url: url)
    }

}
