
\version "2.18.2"

%% additional definitions required by the score:
\language "english"

\paper {
  #(set-paper-size "a4")
  top-margin = 5
  left-margin = 5
  right-margin = 5
  %system-system-spacing = #'((minimum-distance . 5) (padding . 1))
  %annotate-spacing = ##t
}

\header {
  title = \markup { \fontsize #-3 "Συννεφιασμένη Κυριακή"}
  composer = \markup { \fontsize #-3 "Βασίλης Τσιτσάνης"}
}
  
global = {  
  
  \time 9/4
  \key d \major
  \set Staff.midiInstrument = #"acoustic guitar (steel)"
}

sub_a = \relative d' {
  d16[ d' cs b] a16[ g fs e]
}

piece_a = \relative d' {
  \sub_a d16[ cs d ds] e8[ e16 e] e16[ fs g a]
}

piece_b = \relative d' {
   b'8.[ a16] b16[ a g fs] e16[ fs g a] fs16[ e e d]
}

piece_c = \relative d' {
  b'8 cs4 b16[ a] d4. a,8 d4 e e4. d8 d8[ d]
}

mpouzouki = \relative d' {    
   \global
    
    \partial 8 a8
    d16[ d d e] fs16[ g a cs] b8[ a16 cs] b8[ a] d4. a8 d4 e e r8 d8 d,8[ d] \piece_b 
    \sub_a d16[ a fs a] d8[ d] d8[ d] e8[ e16 d] e16[fs g a] fs4. a,8 
    \repeat tremolo 4 { d16 }%re16[ re re re]
    e16[ fs g a] fs16[ d e fs] g8.[ fs16] e8[ e16 d] a'8[ g] fs8[ e] \piece_a
    \break
    \piece_c
    \piece_b \piece_a
    \piece_c
    \break
    \piece_b \sub_a d8[ a] d2
}

guitar = \relative d {
  \global
  \improvisationOn
  \skip8 
  d4 d8[d] d4 r4 d4 d8[d] d4 e e | \break
  d4 d8[g] g4 r4 a4 a8[a] d4 d d | \break
  d4 d8[g] g4 r4 a4 a8[a] d4 d d | \break
  d4 d8[g] g4 r4 a4 a8[a] d4 d d | \break
  d4 d8[g] g4 r4 a4 a8[a] d4 d d | \break
  d4 d8[g] g4 r4 a4 a8[a] d4 d d | \break
  d4 d8[g] g4 r4 a4 a8[a] d4 d d | \break
  d4 d8[g] g4 r4 a4 a8[a] d4 d d | \break
}

guitar_chords = \chordmode {
  %\skip8
  %d2 \skip1 \skip4 e2:m |
}

\score {
  \new StaffGroup <<
    \new Staff {     
       \tempo 4 = 50        
       \mpouzouki
       \bar "|."  
    }  
    \context ChordNames {
      \guitar_chords
    }
    \new Staff {
      \new Voice \with {
        \consists "Pitch_squash_engraver"
      }
      \guitar
      \bar "|."
    }
  >>  
  \layout {}
}

\score {  
  \new StaffGroup <<
    \new Staff {
      \set Staff.midiInstrument = #"acoustic guitar (steel)"
      \set Staff.midiMinimumVolume = #0.7
      \set Staff.midiMaximumVolume = #0.9
      \unfoldRepeats {\mpouzouki}  
    }
    \new Staff {
      \set Staff.midiInstrument = #"acoustic guitar (nylon)"
      \set Staff.midiMinimumVolume = #0.3
      \set Staff.midiMaximumVolume = #0.4
      \unfoldRepeats {\guitar}
    }
    \new Staff {
      \set Staff.midiInstrument = #"acoustic guitar (nylon)"
      \set Staff.midiMinimumVolume = #0.3
      \set Staff.midiMaximumVolume = #0.4
      \unfoldRepeats {\guitar_chords}
    }
  >>
  
  \midi {
    \context {
      \StaffGroup
      \consists "Staff_performer"
    }
    \tempo 4 = 50
  }
}

