//
//  XIcon.swift
//  UltimateChords
//
//  Created by Aung Ko Min on 21/3/22.
//

import SwiftUI

struct XIcon: View {
    
    enum Icon: String, CaseIterable {
        
        case square_and_arrow_up, square_and_pencil, chevron_left, xmark, pencil, scribble, trash, music_note, music_note_list, music_quarternote_3, heart_fill, heart, star, star_fill, tuningfork, music_note_house, camera_viewfinder, photo_on_rectangle_fill, paintpalette, a_magnify, equal_circle, chevron_backward, chevron_down, chevron_up, textformat_size, music_note_tv, text_viewfinder, info_circle_fill, guitars, arrow_up_circle_fill, arrow_down_circle_fill, keyboard, square_and_arrow_down, delete_left_fill, power, power_circle_fill, gobackward, goforward, plus, hand_point_up_left_fill, textformat_abc, textformat_alt, function, camera_filters, mic_fill, doc_append, highlighter, magazine, calendar, lineweight, metronome, link, magnifyingglass, arrow_down_app_fill, rectangle_and_pencil_and_ellipsis, curlybraces, equal, line_3_horizontal, person_circle_fill, book_fill, book, character_book_closed, square_stack_3d_down_right
        
        var systemName: String {
            return self.rawValue.replacingOccurrences(of: "_", with: ".")
        }
    }
    
    private let icon: Icon
    
    init(_ icon: Icon) {
        self.icon = icon
    }
    
    var body: some View {
        Image(systemName: icon.systemName)
            
    }
}
