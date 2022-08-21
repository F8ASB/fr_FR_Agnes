###############################################################################
#
# Locale specific functions for playing back time, numbers and spelling words.
# Often, the functions in this file are the only ones that have to be
# reimplemented for a new language pack.
#
###############################################################################

#
#  25/06/2011   F1SMF    modif  for fr_FR
#   04/04/2016  F8ASB Add playTemp read temperature datas for fr_FR
# Spell the specified word using a phonetic alphabet
#
proc spellWord {word} {
  set word [string tolower $word];
  for {set i 0} {$i < [string length $word]} {set i [expr $i + 1]} {
    set char [string index $word $i];
    if {$char == "*"} {
      playMsg "Default" "star";
    } elseif {$char == "/"} {
      playMsg "Default" "slash";
    } elseif {$char == "-"} {
      playMsg "Default" "dash";
    } elseif {[regexp {[a-z0-9]} $char]} {
      playMsg "Default" "phonetic_$char";
    }
  }
}


#
# Spell the specified number digit for digit
#
proc spellNumber {number} {
  for {set i 0} {$i < [string length $number]} {set i [expr $i + 1]} {
    set ch [string index $number $i];
    if {$ch == "."} {
      playMsg "Default" "decimal";
    } else {
      playMsg "Default" "$ch";
    }
  }
}


#
# Say the specified two digit number (00 - 99)
#
proc playTwoDigitNumber {number} {
  if {[string length $number] != 2} {
    puts "*** WARNING: Function playTwoDigitNumber received a non two digit number: $number";
    return;
  }

  set first [string index $number 0];
if {($first == "0") || ($first == "O")} {
    playMsg "Default" $first;
    playMsg "Default" [string index $number 1];
   }  elseif {$first == "1"} {
        playMsg "Default" $number;
        }  elseif {$first == "7"} {
             playMsg "Default" "6X";
             if {[string index $number 1] == "1"} {
                 playMsg "Default" "and";
             }
             playMsg "Default" [expr $number - 60];
             } elseif {$first == "9"}  {
                  playMsg "Default" "8X";
                  playMsg "Default" [expr $number - 80];
                  } else {
                    playMsg "Default" "[string index $number 0]X";
                    if {[string index $number 1] == "1"} {
                        playMsg "Default" "and";
                    }
                    if {[string index $number 1] != "0"} {
                         playMsg "Default" "[string index $number 1]";
                    }
                  }
             }
#
# Say the specified three digit number (000 - 999)
#
proc playThreeDigitNumber {number} {
  if {[string length $number] != 3} {
    puts "*** WARNING: Function playThreeDigitNumber received a non three digit number: $number";
    return;
  }
  
  set first [string index $number 0];
    if {($first == "0") || ($first == "O")} {
    spellNumber $number
  } else {
    append first "00";
    playMsg "Default" $first;
    if {[string index $number 1] != "0"} {
      playTwoDigitNumber [string range $number 1 2];
    } elseif {[string index $number 2] != "0"} {
      playMsg "Default" [string index $number 2];
    }
  }
}
proc playFourDigitNumber {number} {
  if {[string length $number] != 4} {
    puts "*** WARNING: Function playFourDigitNumber received a non four digit number:$
    return;
  }
 
  set first [string index $number 0];
    if {($first == "1")} {
    playMsg "Default" "1000";
  } elseif {($first == "2")} {
    playMsg "Default" "2000";
  } elseif {($first == "3")} {
    playMsg "Default" "3000";
  } elseif {($first == "4")} {
    playMsg "Default" "4000";
  } elseif {($first == "5")} {
    playMsg "Default" "5000";
  } elseif {($first == "6")} {
    playMsg "Default" "6000";
  } elseif {($first == "7")} {
    playMsg "Default" "7000";
  } elseif {($first == "8")} {
    playMsg "Default" "8000";
  } elseif {($first == "9")} {
    playMsg "Default" "9000";  
  }
  set first [string index $number 1];
    if {($first == "0") || ($first == "O")} {
    playNumber [string range $number 2 5];
    } else {
    playNumber [string range $number 1 5];
    }
 }



#Say Wind Direction as as intelligent as posible.
proc playWindDir {windDir} {

if { 0 < $windDir && $windDir < 22.5} {
        puts "  Direction N"
        playMsg "WeatherStation" "North";
    } elseif {$windDir >= 22.5 && $windDir < 45 } {
        puts "  Direction N NE"
        playMsg "WeatherStation" "North";
        playMsg "WeatherStation" "North-East";
    } elseif {$windDir >= 45 && $windDir < 67.5 } {
        puts "  Direction NE"
        playMsg "WeatherStation" "North-East";
    } elseif {$windDir >= 67.5 && $windDir < 90 } {
        puts "  Direction NE E"
        playMsg "WeatherStation" "North-East";
        playMsg "WeatherStation" "East";
    } elseif {$windDir >= 90 && $windDir < 112.5 } {
        puts "  Direction E"
        playMsg "WeatherStation" "East";
    } elseif {$windDir >= 112.5 && $windDir < 135 } {
        puts "  Direction E SE"
        playMsg "WeatherStation" "East";
    } elseif {$windDir >= 135 && $windDir < 157.5 } {
        puts "  Direction SE"
        playMsg "WeatherStation" "South-East";
    } elseif {$windDir >= 157.5 && $windDir < 180 } {
        puts "  Direction SE S"
        playMsg "WeatherStation" "South-East";
        playMsg "WeatherStation" "South";
    } elseif {$windDir >= 180 && $windDir < 202.5} {
        puts "  Direction S"
        playMsg "WeatherStation" "South";
    } elseif {$windDir >= 202.5 && $windDir < 225 } {
        puts "  Direction S SW"
        playMsg "WeatherStation" "South";
        playMsg "WeatherStation" "South-West";
    } elseif {$windDir >= 225 && $windDir < 247.5} {
        puts "  Direction SW"
        playMsg "WeatherStation" "South-West";
    } elseif {$windDir >= 247.5 && $windDir < 270 } {
        puts "  Direction SW W"
        playMsg "WeatherStation" "South-West";
        playMsg "WeatherStation" "West";
    } elseif {$windDir >= 270 && $windDir < 292.5} {
        puts "  Direction W"
        playMsg "WeatherStation" "West";
    } elseif {$windDir >= 292.5 && $windDir < 315 } {
        puts "  Direction W NW"
        playMsg "WeatherStation" "West";
        playMsg "WeatherStation" "North-West";
    } elseif {$windDir >= 315 && $windDir < 337.5} {
        puts "  Direction NW"
       playMsg "WeatherStation" "North-West";
    } elseif {$windDir >= 337.5 && $windDir < 359 } {
        puts "  Direction NW N"
       playMsg "WeatherStation" "North-West";
       playMsg "WeatherStation" "North";
    } else {
        puts "  Non disponible"
    }
    }




#
# Say a number as intelligent as posible. Examples:
#
#	1	- one
#	24	- twentyfour
#	245	- twohundred and fourtyfive
#	1234	- twelve thirtyfour
#	12345	- onehundred and twentythree fourtyfive
#	136.5	- onehundred and thirtysix point five
#
proc playNumber {number} {
  if {[regexp {(\d+)\.(\d+)?} $number -> integer fraction]} {
    playNumber $integer;


# No say 0 if decimal = 0
if {$fraction != 0} {
    playMsg "Default" "decimal";
    spellNumber $fraction;
}

    return;
  }

  while {[string length $number] > 0} {
    set len [string length $number];
    if {$len == 1} {
      playMsg "Default" $number;
      set number "";
    } elseif {$len % 2 == 0} {
      playTwoDigitNumber [string range $number 0 1];
      set number [string range $number 2 end];
    } else {
      playThreeDigitNumber [string range $number 0 2];
      set number [string range $number 3 end];
    }
  }
}

#
# Say temperature as intelligent as posible. Examples:
#
#       1       - one
#       24      - twentyfour
#       245     - twohundred and fourtyfive
#       1234    - twelve thirtyfour
#       12345   - onehundred and twentythree fourtyfive
#       136.5   - onehundred and thirtysix point five
#
proc playTemp {number} {
  if {[regexp {(\d+)\.(\d+)?} $number -> integer fraction]} {
    playNumber $integer;
    playMsg "WeatherStation" "degree";

# No say 0 if decimal = 0
if {$fraction != 0} {
    spellNumber $fraction;
}
   return;
}

  while {[string length $number] > 0} {
    set len [string length $number];
    if {$len == 1} {
      playMsg "Default" $number;
      set number "";
    } elseif {$len % 2 == 0} {
      playTwoDigitNumber [string range $number 0 1];
      set number [string range $number 2 end];
    } else {
      playThreeDigitNumber [string range $number 0 2];
      set number [string range $number 3 end];
    }
  }
}

#
# Say Voltage as intelligent as possible. Examples:
#
 
proc playVoltage {number} {
if {[regexp {(\d+)\.(\d+)?} $number -> integer fraction]} {
    playNumber $integer;
    playMsg "Default" "volts";
 
# No say 0 if decimal = 0
if {$fraction != 0} {
    spellNumber $fraction;
}
   return;
}
 
  while {[string length $number] &gt; 0} {
    set len [string length $number];
    if {$len == 1} {
      playMsg "Default" $number;
      set number "";
    } elseif {$len % 2 == 0} {
      playTwoDigitNumber [string range $number 0 1];
      set number [string range $number 2 end];
    } else {
      playThreeDigitNumber [string range $number 0 2];
      set number [string range $number 3 end];
    }
  }
}



#
# Say the time specified by function arguments "hour" and "minute".
#
proc playTime {hour minute} {
# Strip white space and leading zeros. Check ranges.
  if {[scan $hour "%d" hour] != 1 || $hour < 0 || $hour > 23} {
    error "playTime: Non digit hour or value out of range: $hour"
  }
  if {[scan $minute "%d" minute] != 1 || $minute < 0 || $minute > 59} {
    error "playTime: Non digit minute or value out of range: $hour"
  }
  if {[string length $hour] == 1} {
     playMsg "Default" [expr $hour];
   } else {
     playTwoDigitNumber $hour;
    }
#  playSilence 250
  playMsg "Core" "time";

   if {$minute == 0} {
     return;
   }
    if {[string length $minute] == 1} {
        playMsg "Default" [expr $minute];
    } else {
        playTwoDigitNumber  $minute;
    }
}

#
# This file has not been truncated
#
