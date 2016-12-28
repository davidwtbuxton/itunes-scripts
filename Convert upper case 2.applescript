-- 24 May 2010, change album and artist too
property letters_uc : (characters of "ABCDEFGHIJKLMNOPQRSTUVWXYZ®Î¯?")
property letters_lc : (characters of "abcdefghijklmnopqrstuvwxyz¾Ï¿?")
property letters_dia_uc : (characters of "çËå€Ì‚ƒéæèêíëì„îñï…Íòôó†Ù")
property letters_dia_lc : (characters of "‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸØ")
property letters_nondia_uc : (characters of "AAAAAACEEEEIIIINOOOOOUUUUY")
property letters_nondia_lc : (characters of "aaaaaaceeeeiiiinooooouuuuy")

-- get selected tracks
tell application "iTunes"
	set selectedTracks to selection
end tell

repeat with aTrack in selectedTracks
	tell application "iTunes"
		set newName to my change_case(name of aTrack, "upper", false)
		set newAlbum to my change_case(album of aTrack, "upper", false)
		set newArtist to my change_case(artist of aTrack, "upper", false)
		set name of aTrack to newName
		set album of aTrack to newAlbum
		set artist of aTrack to newArtist
	end tell
end repeat



-- function to change case
on change_case(the_string, convert_case, strip_diacriticals)
	if strip_diacriticals = true then
		set letters_dia_uc_replace to letters_nondia_uc
		set letters_dia_lc_replace to letters_nondia_lc
	else
		set letters_dia_uc_replace to letters_dia_uc
		set letters_dia_lc_replace to letters_dia_lc
	end if
	if convert_case = "lower" then
		set search_chars to letters_uc & letters_dia_uc
		set replace_chars to letters_lc & letters_dia_lc_replace
	else
		set search_chars to letters_lc & letters_dia_lc
		set replace_chars to letters_uc & letters_dia_uc_replace
	end if
	set return_string to ""
	repeat with i from 1 to (count of characters of the_string)
		set string_char to (character i of the_string)
		if search_chars contains string_char then
			repeat with j from 1 to (count of search_chars)
				if (item j of search_chars) = string_char then
					set return_string to return_string & (item j of replace_chars)
					exit repeat
				end if
			end repeat
		else
			set return_string to return_string & string_char
		end if
	end repeat
	return return_string as string
end change_case
