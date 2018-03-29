uses crt, sysutils;

type
	decktype = array[1..40,1..2] of byte; {current, max}
	cardtype = array[1..4,1..12] of integer; {player, hand}
	propertytype = array[1..4, 1..10] of byte; {player, no. of certain properties}
	propmaxtype = array[1..10] of byte;
	cardNotype = array[1..4] of integer;
	moneytype = array[1..20] of byte;	{1-20: types of money}
	haveNotype = array[1..4] of byte;
	housetype = array[1..4, 1..10] of byte;

var
    cardamount: array[1..40] of integer;
	cardshortform: array[1..40] of string;
    cardinfo: array[1..40, 1..3] of string;
	opt_addr: string;
	cur_textcolor: integer;
	
procedure GenOption;
var 
	opt: text;
begin
	opt_addr := GetCurrentDir + '\Option.txt';
	if not (FileExists(opt_addr)) then
	begin
		assign(opt, opt_addr);
		rewrite	(opt);
		writeln(opt, 'Text color: (Default: white(15))');
		writeln(opt, '15');
		close(opt);
	end;
end;

procedure LoadOption;
var
	i, input: integer;
	opt: text;
begin
	i := 0;

	assign(opt, opt_addr);
	reset(opt);
	repeat
		i := i + 1;
		readln(opt);
		readln(opt, input);
		case i of
			1:	cur_textcolor := input;
		end;
	until eof(opt);
	close(opt);
end;
	
procedure GenList;
begin
    cardamount[1] := 2;
    cardamount[2] := 3;
    cardamount[3] := 3;
    cardamount[4] := 4;
    cardamount[5] := 3;
    cardamount[6] := 3;
    cardamount[7] := 10;
    cardamount[8] := 3;
    cardamount[9] := 3;
    cardamount[10] := 2;
    cardamount[11] := 2;
    cardamount[12] := 2;
    cardamount[13] := 2;
    cardamount[14] := 2;
    cardamount[15] := 2;
    cardamount[16] := 3;
    cardamount[17] := 3;
    cardamount[18] := 2;
    cardamount[19] := 3;
    cardamount[20] := 3;
    cardamount[21] := 3;
    cardamount[22] := 2;
    cardamount[23] := 3;
    cardamount[24] := 3;
    cardamount[25] := 2;
    cardamount[26] := 4;
    cardamount[27] := 2;
    cardamount[28] := 1;
    cardamount[29] := 1;
    cardamount[30] := 1;
    cardamount[31] := 1;
    cardamount[32] := 2;
    cardamount[33] := 1;
    cardamount[34] := 2;
    cardamount[35] := 1;
    cardamount[36] := 2;
    cardamount[37] := 3;
    cardamount[38] := 3;
    cardamount[39] := 5;
    cardamount[40] := 6;
	
	cardshortform[1] := 'DB';
    cardshortform[2] := 'NO';
    cardshortform[3] := 'SD';
    cardshortform[4] := 'FD';
    cardshortform[5] := 'DC';
    cardshortform[6] := 'IMB';
    cardshortform[7] := 'GO';
    cardshortform[8] := 'HOU';
    cardshortform[9] := 'HOT';
    cardshortform[10] := 'DR';
    cardshortform[11] := 'POR';
    cardshortform[12] := 'RUR';
    cardshortform[13] := 'GDR';
    cardshortform[14] := 'BLR';
    cardshortform[15] := 'RYR';
    cardshortform[16] := 'TR';
    cardshortform[17] := 'GP';
    cardshortform[18] := 'DBP';
    cardshortform[19] := 'RP';
    cardshortform[20] := 'YP';
    cardshortform[21] := 'OP';
    cardshortform[22] := 'BP';
    cardshortform[23] := 'LBP';
    cardshortform[24] := 'PP';
    cardshortform[25] := 'UP';
    cardshortform[26] := 'RRP';
    cardshortform[27] := 'POW';
    cardshortform[28] := 'LBW';
    cardshortform[29] := 'LRW';
    cardshortform[30] := 'DGW';
    cardshortform[31] := 'RGW';
    cardshortform[32] := 'RYW';
    cardshortform[33] := 'URW';
    cardshortform[34] := 'TW';
    cardshortform[35] := '$10';
    cardshortform[36] := '$5';
    cardshortform[37] := '$4';
    cardshortform[38] := '$3';
    cardshortform[39] := '$2';
    cardshortform[40] := '$1';
	
	cardinfo[1,1] := 'Deal Breaker';
	cardinfo[1,2] := '$5M';
	cardinfo[1,3] := 'Steal a complete set of property from any player.';
	cardinfo[2,1] := 'Just Say No';
	cardinfo[2,2] := '$4M';
	cardinfo[2,3] := 'Use any time when an action card is played against you.';
	cardinfo[3,1] := 'Sly Deal';
	cardinfo[3,2] := '$3M';
	cardinfo[3,3] := 'Steal a property from the player of your choice. The property cannot be a part of a full set.';
	cardinfo[4,1] := 'Forced Deal';
	cardinfo[4,2] := '$3M';
	cardinfo[4,3] := 'Swap any property with another player. The property cannot be a part of a full set.';
	cardinfo[5,1] := 'Debt Collector';
	cardinfo[5,2] := '$3M';
	cardinfo[5,3] := 'Force any player to pay you $5M.';
	cardinfo[6,1] := 'It''s My Birthday';
	cardinfo[6,2] := '$2M';
	cardinfo[6,3] := 'All players give you $2M as gift.';
	cardinfo[7,1] := 'Pass GO';
	cardinfo[7,2] := '$1M';
	cardinfo[7,3] := 'Draw 2 extra cards.';
	cardinfo[8,1] := 'House';
	cardinfo[8,2] := '$3M';
	cardinfo[8,3] := 'Add onto any full set you own (Except Railroads and Utilities) to add $3M to the Rent value.';
	cardinfo[9,1] := 'Hotel';
	cardinfo[9,2] := '$4M';
	cardinfo[9,3] := 'Add onto any full set you own (Except Railroads and Utilities) to add $4M to the Rent value.';
	cardinfo[10,1] := 'Double the rent';
	cardinfo[10,2] := '$1M';
	cardinfo[10,3] := 'Needs to be played with a Rent card. It literally doubles your rent income. ';
	cardinfo[11,1] := 'Purple and Orange rent cards';
	cardinfo[11,2] := '$1M';
	cardinfo[11,3] := 'All player pay you rent for properties you own in purple or orange color.';
	cardinfo[12,1] := 'Railroad and Utility rent cards';
	cardinfo[12,2] := '$1M';
	cardinfo[12,3] := 'All player pay you rent for railroad or utilities you own.';
	cardinfo[13,1] := 'Green and Dark Blue rent cards';
	cardinfo[13,2] := '$1M';
	cardinfo[13,3] := 'All player pay you rent for properties you own in green or dark blue color.';
	cardinfo[14,1] := 'Brown and Light Blue rent cards';
	cardinfo[14,2] := '$1M';
	cardinfo[14,3] := 'All player pay you rent for properties you own in brown or light blue color.';
	cardinfo[15,1] := 'Red and Yellow rent cards';
	cardinfo[15,2] := '$1M';
	cardinfo[15,3] := 'All player pay you rent for properties you own in red or yellow color.';
	cardinfo[16,1] := 'ten color wild rent cards';
	cardinfo[16,2] := '$3M';
	cardinfo[16,3] := 'Force one player to pay you rent for properties you own in any color.';
	cardinfo[17,1] := 'Green properties';
	cardinfo[17,2] := '$4M';
	cardinfo[17,3] := 'No. of properties owned in set (Rent): 1($2M) 2($4M) (Full set)3($7M)';
	cardinfo[18,1] := 'Dark Blue properties';
	cardinfo[18,2] := '$4M';
	cardinfo[18,3] := 'No. of properties owned in set (Rent): 1($3M) (Full set)2($8M)';
	cardinfo[19,1] := 'Red properties';
	cardinfo[19,2] := '$3M';
	cardinfo[19,3] := 'No. of properties owned in set (Rent): 1($2M) 2($3M) (Full set)3($6M)';
	cardinfo[20,1] := 'Yellow properties';
	cardinfo[20,2] := '$3M';
	cardinfo[20,3] := 'No. of properties owned in set (Rent): 1($2M) 2($4M) (Full set)3($6M)';
	cardinfo[21,1] := 'Orange properties';
	cardinfo[21,2] := '$2M';
	cardinfo[21,3] := 'No. of properties owned in set (Rent): 1($1M) 2($3M) (Full set)3($5M)';
	cardinfo[22,1] := 'Brown properties';
	cardinfo[22,2] := '$1M';
	cardinfo[22,3] := 'No. of properties owned in set (Rent): 1($1M) (Full set)2($2M)';
	cardinfo[23,1] := 'Light Blue properties';
	cardinfo[23,2] := '$1M';
	cardinfo[23,3] := 'No. of properties owned in set (Rent): 1($1M) 2($2M) (Full set)3($3M)';
	cardinfo[24,1] := 'Purple properties';
	cardinfo[24,2] := '$2M';
	cardinfo[24,3] := 'No. of properties owned in set (Rent): 1($1M) 2($2M) (Full set)3($4M)';
	cardinfo[25,1] := 'Utility properties';
	cardinfo[25,2] := '$2M';
	cardinfo[25,3] := 'No. of properties owned in set (Rent): 1($1M) (Full set)2($2M)';
	cardinfo[26,1] := 'Railroad properties';
	cardinfo[26,2] := '$2M';
	cardinfo[26,3] := 'No. of properties owned in set (Rent): 1($1M) 2($2M) 3($3M) (Full set)4($4M)';
	cardinfo[27,1] := 'Purple and Orange wildcards';
	cardinfo[27,2] := '$2M';
	cardinfo[27,3] := 'Can act as purple or orange properties.';
	cardinfo[28,1] := 'Light Blue and Brown wildcards';
	cardinfo[28,2] := '$1M';
	cardinfo[28,3] := 'Can act as light blue or brown properties.';
	cardinfo[29,1] := 'Light Blue and Railroad wildcards';
	cardinfo[29,2] := '$4M';
	cardinfo[29,3] := 'Can act as light blue or railroad properties.';
	cardinfo[30,1] := 'Dark Blue and Green wildcards';
	cardinfo[30,2] := '$4M';
	cardinfo[30,3] := 'Can act as dark blue or green properties.';
	cardinfo[31,1] := 'Railroad and Green wildcards';
	cardinfo[31,2] := '$4M';
	cardinfo[31,3] := 'Can act as railroad or green properties.';
	cardinfo[32,1] := 'Red and Yellow wildcards';
	cardinfo[32,2] := '$3M';
	cardinfo[32,3] := 'Can act as red or yellow properties.';
	cardinfo[33,1] := 'Utility and Railroad wildcards';
	cardinfo[33,2] := '$2M';
	cardinfo[33,3] := 'Can act as utility or railroad properties.';
	cardinfo[34,1] := '10 multi-color wildcards';
	cardinfo[34,2] := 'No Monetary Value';
	cardinfo[34,3] := 'Can be used as part of any property set.';
	cardinfo[35,1] := '$10M money card';
	cardinfo[35,2] := '$10M';
	cardinfo[35,3] := 'Put into your bank to pay other players.';
	cardinfo[36,1] := '$5M money cards';
	cardinfo[36,2] := '$5M';
	cardinfo[36,3] := 'Put into your bank to pay other players.';
	cardinfo[37,1] := '$4M money cards';
	cardinfo[37,2] := '$4M';
	cardinfo[37,3] := 'Put into your bank to pay other players.';
	cardinfo[38,1] := '$3M money cards';
	cardinfo[38,2] := '$3M';
	cardinfo[38,3] := 'Put into your bank to pay other players.';
	cardinfo[39,1] := '$2M money cards';
	cardinfo[39,2] := '$2M';
	cardinfo[39,3] := 'Put into your bank to pay other players.';
	cardinfo[40,1] := '$1M money cards';
	cardinfo[40,2] := '$1M';
	cardinfo[40,3] := 'Put into your bank to pay other players.';
end;
		
procedure MainMenu(init: boolean ; var outcome: byte);
var
	pointer: byte;
	done: boolean;
	ch: char;
begin
//	writeln(pointer);	writeln(outcome);	readln;
	done := false;
	writeln;
	writeln('            |=======================================================|');
	writeln('            |            ___          ___   ___   ___               |');
	writeln('            |   |\   /| |   | |\   | |   | |   | |   | |   \   /    |');
	writeln('            |   | \ / | |   | | \  | |   | |___| |   | |    \ /     |');
	writeln('            |   |  V  | |   | |  \ | |   | |     |   | |     V      |');
	writeln('            |   |     | |   | |   \| |   | |     |   | |     |      |');
	writeln('            |   |     | |___| |    | |___| |     |___| |___  |      |');
	writeln('            |                  ___    ___   ___                     |');
	writeln('            |                 |   \  |     |   | |                  |');
	writeln('            |                 |    | |___  |___| |                  |');
	writeln('            |                 |    | |     |   | |                  |');
	writeln('            |                 |    | |     |   | |                  |');
	writeln('            |                 |___/  |___  |   | |___               |');
	writeln('            |                                                       |');
	writeln('            |=======================================================|');
	writeln;		
    writeln('            Local Game');
	writeln;
  	writeln('            Multi-Player(if possible)');
	writeln;
	writeln('            Tutorial');
	writeln;
	writeln('            Option');
	writeln;
	writeln('            Exit');
	writeln;
	writeln('Version Alpha 1.0.19                                                  By Goggle');
	
	repeat
		if init then
		begin
			init := false;
			pointer := 0;
			outcome := 0;
		end
		else
		begin
			repeat
				done := false;
				ch := ReadKey;
				If ord(ch)=0 then
					ch:=readkey; 
			until ord(ch) in [72,80];
				
			case ch of
				#72 : 	begin
							gotoxy(10,18 + 2 * pointer);
							write(' ');
							pointer := (pointer + 4) mod 5;
	//						writeln(pointer);
	//						writeln('up');
						end;
				#80 :	begin
							gotoxy(10,18 + 2 * pointer);
							write(' ');
							pointer := (pointer + 1) mod 5;
	//						writeln(pointer);
	//						writeln('down');
						end;
			end;
		end;
        
        gotoxy(10,18 + 2 * pointer);
        write('>');
		
		
		ch := ReadKey;
		if ch = #13 then
		begin		
			outcome := pointer;
			done := true;
		end;
			
	until done;
end;

procedure draw(pNo: integer; var card: cardtype; var cardNo: cardNotype; var deck: decktype; drawNo: integer);
var
	j, drawn: integer;
begin
	for j := cardNo[pNo] + 1 to cardNo[pNo] + drawNo do
	begin
		repeat
			drawn := random(40)+ 1;
		until deck[drawn,1] < deck[drawn,2];
		card[pNo,j] := drawn;
		deck[drawn,1] := deck[drawn,1] + 1;
	end;
	cardNo[pNo] := cardNo[pNo] + drawNo;
end;

procedure numtotext(cardNum: integer);
begin
	write(cardshortform[cardNum]:3, ' ');
end;

procedure display(pNo: integer; var card: cardtype; var cardNo: cardNotype; var money: moneytype; var properties: propertytype; var propmax: propmaxtype; var house, hotel: housetype);
var
	i, j, k, m: integer;
begin
	for i := 1 to 4 do
	begin		
		case i of
			1: 	begin
					gotoxy(1,3);
					write('Player 1   ');
					for j := 1 to 20 do
						if money[j] = i then
							case j of
								1:	write('10M ');
								2..3:	write('5M ');
								4..6:	write('4M ');
								7..9:	write('3M ');
								10..14:	write('2M ');
								15..20:	write('1M ');	
							end;
					gotoxy(1,5);
				end;
			2:  begin
					gotoxy(70,3);
					write('Player 2   ');
					for j := 1 to 20 do
						if money[j] = i then
							case j of
								1:	write('10M ');
								2..3:	write('5M ');
								4..6:	write('4M ');
								7..9:	write('3M ');
								10..14:	write('2M ');
								15..20:	write('1M ');	
							end;				
					gotoxy(70,5);
				end;
			3:	begin
					gotoxy(70,19);
					write('Player 3   ');
					for j := 1 to 20 do
						if money[j] = i then
							case j of
								1:	write('10M ');
								2..3:	write('5M ');
								4..6:	write('4M ');
								7..9:	write('3M ');
								10..14:	write('2M ');
								15..20:	write('1M ');
							end;
					gotoxy(70,21);
				end;
			4:	begin	
					gotoxy(1,19);	
					write('Player 4   ');
					for j := 1 to 20 do
						if money[j] = i then
							case j of
								1:	write('10M ');
								2..3:	write('5M ');
								4..6:	write('4M ');
								7..9:	write('3M ');
								10..14:	write('2M ');
								15..20:	write('1M ');
							end;
					gotoxy(1,21);
				end;		
	    end;		
		
		for j := 1 to cardNo[i] do
		begin
			if card[i,j] <> 0 then
			begin
				if i <> pNo then
				begin	
					textbackground(7);
					write('   ');
					textbackground(0);
					write(' ');
				end
				else
//					write(card[i,j]:3, ' ');
					numtotext(card[i,j]);
				if j = 6 then
				begin
					case i of
						1:	gotoxy(1,7);
						2:	gotoxy(70,7);
						3:	gotoxy(70,23);
						4:	gotoxy(1,23);
					end;						
				end;
				k := k + 1;
			end;
		end;	

		m := 0;
					
		for j := 1 to 10 do
		if properties[i, j] > 0 then
		begin
			case i of
				1:	gotoxy(1,9 + m);
				2:	gotoxy(70,9 + m);
				3:	gotoxy(70,25 + m);
				4:	gotoxy(1,25 + m);
			end;
			write(cardinfo[16+j,1], ': ', properties[i, j]);
			if properties[i, j] = propmax[j] then
				write(' (full)');
			if house[i, j] <> 0 then
				write('  ', house[i,j] div 3, ' house(s)');
			if hotel[i, j] <> 0 then
				write('  ', hotel[i,j] div 4, ' hotel(s)');
			m := m + 1;
		end;
	end;
	
	gotoxy(40,10);
	writeln('i for more info,');
	gotoxy(32,11);
	writeln('(space) for using the selected card,');
	gotoxy(35,12);
	writeln('(enter) to go to next turn.');
end;

procedure info(selCard: integer);
begin
	//	writeln(selCard:5);
	writeln('Name: ', cardinfo[selCard,1]);
	writeln;
	writeln('Value: ', cardinfo[selCard,2]);
	writeln;
	writeln('Detail info: ', cardinfo[selCard,3]);	
	writeln;
	write('Press enter to return.');
end;

procedure pay(collector: byte; value: byte; target: byte; var money: moneytype; var haveNo: haveNotype; var denied: boolean); //target: 5 = all
var
	i, j, k, count, count2, pointer: integer;
	ch: char;
	a: array[1..20,1..2] of byte;
begin
	if target <> 5 then
	begin
		for i := 1 to 2 do
			for j := 1 to 20 do
				a[j, i] := 0;
				
		i := 0; count := 0; denied := false;
		
		for j := 1 to 20 do
			if money[j] = target then
			begin
				i := i + 1;
				a[i, 2] := j;
				case j of
					1:	begin
							count := count + 10;
							a[i, 1] := 10;
						end;
					2..3:	begin
								count := count + 5;
								a[i, 1] := 5;
							end;
					4..6:	begin
								count := count + 4;
								a[i, 1] := 4;
							end;
					7..9:	begin
								count := count + 3;
								a[i, 1] := 3;
							end;
					10..14:	begin
								count := count + 2;
								a[i, 1] := 2;
							end;
					15..20:	begin	
								count := count + 1;
								a[i, 1] := 1;
							end;	
				end;
			end;
		
		count2 := 0;	pointer := 0;
		
		if count >= value then				
			repeat
				clrscr;
				writeln('Player ', target, ', please pay ', value,'M.');
				writeln;	writeln;
				for j := 1 to i do
					write(a[j,1],'M ');
					
				writeln;
				writeln;
				writeln('Paid: ',count2);
				
				if haveNo[target] > 0 then
				begin
					writeln('You have ''Just Say NO'', do you want to use it? (Y/N)');
					repeat
						ch := readkey;
					until ord(ch) in [89, 121, 78, 110];
					if (ord(ch) = 89) or (ord(ch) = 121) then
						denied := true;
				end;
				
				if not denied then
				begin
					gotoxy(1 + 3 * pointer, 3);
					write('v');
					
					repeat
						ch := readkey;
						If ord(ch)=0 then
							ch := readkey; 
					until ord(ch) in [75,77,32];
							
					case ch of
						#75: 	begin									//left
									gotoxy(1 + 3 * pointer, 3);
									write(' ');
									pointer := (pointer + i - 1) mod i;
								end;
						#77:	begin									//right
									gotoxy(1 + 3 * pointer, 3);
									write(' ');
									pointer := (pointer + 1) mod i;
								end;
						#32:	begin
									count2 := count2 + a[pointer + 1, 1];
									money[a[pointer + 1, 2]] := collector;
									for j := 1 to 2 do
										for k := pointer + 1 to i do	
											a[k, j] := a[k+1, j];
									i := i - 1;
								end;
					end;
				end;
			until (count2 >= value) or (denied);
	end
	else
	begin
		for k := 1 to 4 do
			if k <> collector then
			begin
				clrscr;

	            for i := 1 to 2 do
	             	for j := 1 to 20 do
                        a[j, i] := 0;

                i := 0; count := 0; denied := false;
				
				for j := 1 to 20 do
					if money[j] = k then
					begin
						i := i + 1;
						a[i,2] := j;
						case j of
							1:	begin
									count := count + 10;
									a[i,1] := 10;
								end;
							2..3:	begin
										count := count + 5;
										a[i,1] := 5;
									end;
							4..6:	begin
										count := count + 4;
										a[i,1] := 4;
									end;
							7..9:	begin
										count := count + 3;
										a[i,1] := 3;
									end;
							10..14:	begin
										count := count + 2;
										a[i,1] := 2;
									end;
							15..20:	begin	
										count := count + 1;
										a[i,1] := 1;
									end;	
						end;
					end;
				
				count2 := 0;	pointer := 0;
				
				if count >= value then
					repeat
						clrscr;
						writeln('Player ', k, ', please pay ', value,'M.');
						writeln;	writeln;
						for j := 1 to i do
							write(a[j,1],'M ');
							
						writeln;	writeln;
						writeln('Paid: ',count2);
						
						if haveNo[k] > 0 then
						begin
							writeln('You have ''Just Say NO'', do you want to use it? (Y/N)');
							repeat
								ch := readkey;
							until ord(ch) in [89, 121, 78, 110];
							if (ord(ch) = 89) or (ord(ch) = 121) then
								denied := true;
						end;
							
						if not denied then
						begin
							gotoxy(1 + 3 * pointer, 3);
							write('v');							
							
							repeat
								ch := readkey;
								If ord(ch)=0 then
									ch := readkey; 
							until ord(ch) in [75,77,32];
									
							case ch of
								#75: 	begin									//left
											gotoxy(1 + 3 * pointer, 3);
											write(' ');
											pointer := (pointer + i - 1) mod i;
										end;
								#77:	begin									//right
											gotoxy(1 + 3 * pointer, 3);
											write(' ');
											pointer := (pointer + 1) mod i;
										end;
								#32:	begin
											count2 := count2 + a[pointer + 1, 1];
											money[a[pointer + 1, 2]] := collector;
											for j := 1 to 2 do
												for k := pointer + 1 to i do	
													a[k, j] := a[k+1, j];
											i := i - 1;
										end;
							end;
						end;
					until count2 >= value;
			end;
	end
end;

procedure takeSet (user, target: byte; var properties: propertytype; var propmax: propmaxtype; var haveNo: haveNotype; var denied: boolean);
var
	i, j, pointer: integer;
    ch: char;
	a: array[1..10] of integer;
begin
	pointer := 0; denied := false;
	repeat
		clrscr;
		writeln('Choose the color of property you want to take from player ', target);
		writeln;	writeln;
		j := 0;
		for i := 1 to 10 do
			if properties[target, i] = propmax[i] then
			begin
				case i of
					1: write('Green     ');
					2: write('Dark Blue ');
					3: write('Red       ');
					4: write('Yellow    ');
					5: write('Orange    ');
					6: write('Brown     ');
					7: write('Light Blue');
					8: write(' Purple   ');
					9: write('Utility   ');
					10: write('RailRoad  ');
				end;
				j := j + 1;
				a[j] := i;
			end;
			
		writeln;	writeln;
		if haveNo[target] > 0 then
		begin
			writeln('You have ''Just Say NO'', do you want to use it? (Y/N)');
			repeat
				ch := readkey;
			until ord(ch) in [89, 121, 78, 110];
			if (ord(ch) = 89) or (ord(ch) = 121) then
				denied := true;
		end;
			
		if not denied then	
		begin
			if j = 0 then
			begin
				clrscr;
				writeln('No property to steal.');
				delay(5000);
			end
			else
			begin
			
				gotoxy(5 + 10 * pointer, 3);
				write('v');							
				
				repeat
					ch := readkey;
					If ord(ch)=0 then
						ch := readkey; 
				until ord(ch) in [75,77,32];
										
				case ch of
					#75: 	begin									//left
								gotoxy(5 + 10 * pointer, 3);
								write(' ');
								pointer := (pointer + j - 1) mod j;
							end;
					#77:	begin									//right
								gotoxy(5 + 10 * pointer, 3);
								write(' ');
								pointer := (pointer + 1) mod j;
							end;
					#32:	begin
								properties[target, a[pointer + 1]] := properties[target, a[pointer + 1]] - propmax[pointer + 1];
								properties[user, a[pointer + 1]] := properties[user, a[pointer + 1]] + propmax[pointer + 1];
							end;
				end;
			end;
		end;
	until ch = #32;
end;

procedure transProp (user, target, mode: byte; var properties: propertytype; var haveNo: haveNotype; var denied: boolean); 					//mode: 1 = Forced Deal, 2 = Sly Deal;
var
	i, j, pointer: integer;
    ch: char;
	a: array[1..10] of integer;
begin
	pointer := 0;	denied := false;
	repeat
		clrscr;
		writeln('Choose the color of property you want to take from player ', target);
		writeln;	writeln;
		j := 0;
		for i := 1 to 10 do
			if properties[target, i] >= 1 then
			begin
				case i of
					1: write('Green     ');
					2: write('Dark Blue ');
					3: write('Red       ');
					4: write('Yellow    ');
					5: write('Orange    ');
					6: write('Brown     ');
					7: write('Light Blue');
					8: write(' Purple   ');
					9: write('Utility   ');
					10: write('RailRoad  ');
				end;
				j := j + 1;
				a[j] := i;
			end;
			
		writeln;	writeln;
		if haveNo[target] > 0 then
		begin
			writeln('You have ''Just Say NO'', do you want to use it? (Y/N)');
			repeat
				ch := readkey;
			until ord(ch) in [89, 121, 78, 110];
			if (ord(ch) = 89) or (ord(ch) = 121) then
				denied := true;
		end;
		
		if not denied then
		begin
			if j = 0 then
			begin
				clrscr;
				writeln('No property to steal.');
				delay(5000);
			end
			else
			begin
			
				gotoxy(5 + 10 * pointer, 3);
				write('v');							
				
				repeat
					ch := readkey;
					If ord(ch)=0 then
						ch := readkey; 
				until ord(ch) in [75,77,32];
										
				case ch of
					#75: 	begin									//left
								gotoxy(5 + 10 * pointer, 3);
								write(' ');
								pointer := (pointer + j - 1) mod j;
							end;
					#77:	begin									//right
								gotoxy(5 + 10 * pointer, 3);
								write(' ');
								pointer := (pointer + 1) mod j;
							end;
					#32:	begin
								properties[target, a[pointer + 1]] := properties[target, a[pointer + 1]] - 1;
								properties[user, a[pointer + 1]] := properties[user, a[pointer + 1]] + 1;
							end;
				end;
			end;
		end;
	until (ch = #32) or denied;
	
	if (mode = 1) and (not denied) then
	begin
		pointer := 0;
		repeat
			clrscr;
			writeln('Choose the color of property you want to give player ', target);
			writeln;	writeln;
			j := 0;
			for i := 1 to 10 do
				if properties[user, i] >= 1 then
				begin
					case i of
						1: write('Green     ');
						2: write('Dark Blue ');
						3: write('Red       ');
						4: write('Yellow    ');
						5: write('Orange    ');
						6: write('Brown     ');
						7: write('Light Blue');
						8: write(' Purple   ');
						9: write('Utility   ');
						10: write('RailRoad  ');
					end;
					j := j + 1;
					a[j] := i;
				end;
			if j = 0 then
			begin
				clrscr;
				writeln('No property to give.');
				delay(5000);
			end
			else
			begin
			
				gotoxy(5 + 10 * pointer, 3);
				write('v');							
				
				repeat
					ch := readkey;
					If ord(ch)=0 then
						ch := readkey; 
				until ord(ch) in [75,77,32];
										
				case ch of
					#75: 	begin									//left
								gotoxy(5 + 10 * pointer, 3);
								write(' ');
								pointer := (pointer + j - 1) mod j;
							end;
					#77:	begin									//right
								gotoxy(5 + 10 * pointer, 3);
								write(' ');
								pointer := (pointer + 1) mod j;
							end;
					#32:	begin
								properties[user, a[pointer + 1]] := properties[user, a[pointer + 1]] - 1;
								properties[target, a[pointer + 1]] := properties[target, a[pointer + 1]] + 1;
							end;
				end;
			end;
		until ch = #32;
	end;
end;

procedure local;
var
	denied: boolean;
	haveNo: haveNotype;
	deck: decktype;
	card: cardtype;
	cardNo: cardNotype;
	properties: propertytype;
	propmax: propmaxtype;
	money: moneytype;
	i, j, pNo, pointer, pointer2, action, propchoice, target, value, double: integer;
	house, hotel: housetype;
	fullprop: array[1..10] of byte;
	complete: array[1..4,1..10] of byte;
	win: array[1..4] of byte;
	ch, ch2: char;
begin	
	for i := 1 to 40 do											//load max no. of each card
	begin
		deck[i,2] := cardamount[i];
	end;
		
{	for i := 1 to 40 do
	begin
		writeln(deck[i,2]);
	end;
	readln;}	
	
	for i := 1 to 10 do
	begin
		propmax[i] := deck[i + 16, 2];
	end;
	
	for i := 1 to 40 do											//reset deck
		deck[i,1] := 0;
	
	for i := 1 to 4 do											//reset player's hand, properties and money
	begin
		for j := 1 to 12 do
		begin
			card[i,j] := 0;
		end;
		for j := 1 to 10 do
		begin
			properties[i, j] := 0;
			house[i, j] := 0;
			hotel[i, j] := 0;
		end;
		cardNo[i] := 0;
		win[i] := 0;
	end;
	
	for j := 1 to 20 do
		money[j] := 0;
	
	for i := 1 to 4 do 
		for j := 1 to 10 do
			complete[i,j] := 0;
			
	double := 1;
			
	
//	randomize;

	for i := 1 to 4 do											//initial draw
		draw(i, card, cardNo, deck, 5);
	
{	for i := 1 to 12 do
		writeln(card[1,i]);
	readln;
}
	
{	for i := 1 to 4 do
		writeln(cardNo[i]);
    readln;
}	
		
{	for i := 1 to 4 do
	begin
		for j := 1 to 5 do
			write(card[i,j],' ');
		writeln;
	end;
	readln;
}
	
//	for i := 4 to 5 do
//		card[3,i] := 0;
	
	pNo := 0;													//game process
	repeat	
		pNo := pNo mod 4 + 1;
		
		clrscr;		
		
		if cardNo[pNo] = 0 then
			draw(pNo, card, cardNo, deck, 7)
		else
			draw(pNo, card, cardNo, deck, 2);
			
		for i := 1 to 12 do
			haveNo[i] := 0;
			
		for i := 1 to 12 do
			if card[pNo, i] = 3 then
			begin
				haveNo[i] := haveNo[i] + 1;
				j := i;
			end;
			
//		gotoxy(32,13);			
//		for i := 1 to 4 do
//			write(haveNo[i],'   ');
		
		display(pNo, card, cardNo, money, properties, propmax, house, hotel);

		case pNo of
				1:	gotoxy(2,4);
				2:	gotoxy(71,4);
				3:	gotoxy(71,20);
				4:	gotoxy(2,20);
			end;	
			
		write('v');
{		for i := 1 to 12 do
			writeln(card[1,i]);
		readln;
}
		pointer := 0; action := 0;
		repeat
			repeat
				ch := readkey;
				If ord(ch)=0 then
					ch := readkey; 
			until ord(ch) in [75,77,13,105,32];
					
			case ch of
				#75: 	begin									//left
							case pNo of
								1:	if pointer < 6 then
										gotoxy(2 + 4 * pointer, 4)
									else
										gotoxy(2 + 4 * (pointer - 6), 6);
										
								2:	if pointer < 6 then
										gotoxy(71 +	4 * pointer, 4)
									else
										gotoxy(71 +	4 * (pointer - 6), 6);
										
								3:	if pointer < 6 then
										gotoxy(71 + 4 * pointer, 20)
									else
										gotoxy(71 + 4 * (pointer - 6), 22);
										
								4:	if pointer < 6 then
										gotoxy(2 + 4 * pointer, 20)
									else
										gotoxy(2 + 4 * (pointer - 6), 22);
							end;	 
							write(' ');
							pointer := (pointer + cardNo[pNo] - 1) mod cardNo[pNo];
						end;
				#77:	begin									//right
							case pNo of
								1:	if pointer < 6 then
										gotoxy(2 + 4 * pointer, 4)
									else
										gotoxy(2 + 4 * (pointer - 6), 6);
										
								2:	if pointer < 6 then
										gotoxy(71 +	4 * pointer, 4)
									else
										gotoxy(71 +	4 * (pointer - 6), 6);
										
								3:	if pointer < 6 then
										gotoxy(71 + 4 * pointer, 20)
									else
										gotoxy(71 + 4 * (pointer - 6), 22);
										
								4:	if pointer < 6 then
										gotoxy(2 + 4 * pointer, 20)
									else
										gotoxy(2 + 4 * (pointer - 6), 22);
							end;	
							write(' '); 
							pointer := (pointer + 1) mod cardNo[pNo];
						end;
				#105:	begin									//i (info)
							clrscr;			
							info(card[pNo, pointer + 1]);
							readln;
							clrscr;
						end;
				#32:	begin									//  (space)
							clrscr;
							case card[pNo, pointer + 1] of
								1:	begin																				//Deal Breaker
										clrscr;
										write('Enter your target: ');
										readln(target);
										takeSet(pNo, target, properties, propmax, haveNo, denied);
										if denied then
										begin
											cardNo[target] := cardNo[target] - 1;
											for i := j to cardNo[target] do
												card[target, i] := card[target, i + 1];
										end;
									end;
								2:	begin																				//Just say No
										clrscr;
										writeln('You should not use this card now. Use this any time when an action card is played against you.');
										delay(500);
										action := action + 1;
										cardNo[pNo] := cardNo[pNo] + 1;
										card[pNo, cardNo[pNo]] := 2;
									end;
								3:	begin																				//Sly Deal
										clrscr;
										write('Enter your target: ');
										readln(target);
										transProp(pNo, target, 2, properties, haveNo, denied);
										if denied then
										begin
											cardNo[target] := cardNo[target] - 1;
											for i := j to cardNo[target] do
												card[target, i] := card[target, i + 1];
										end;
                                    end;
								4:	begin																				//Forced Deal
										clrscr;
										write('Enter your target: ');
										readln(target);
										transProp(pNo, target, 1, properties, haveNo, denied);
										if denied then
										begin
											cardNo[target] := cardNo[target] - 1;
											for i := j to cardNo[target] do
												card[target, i] := card[target, i + 1];
										end;
                                    end;
								5:	begin																				//Debt Collector
										clrscr;
										write('Enter your target: ');
										readln(target);
										pay(pNo, 5, target, money, haveNo, denied);
									end;
								6:	pay(pNo, 2, 5, money, haveNo, denied);												//It's my birthday
								7:	draw(pNo, card, cardNo, deck, 2);													//Pass Go
								8:	begin																				//House
										pointer2 := 0;	j := 0;
											
										clrscr;
										writeln('Arrow key to select, space to comfirm the property you want to add a house:');
										writeln;
											
										for i := 1 to 10 do
											if properties[pNo, i] = propmax[i] then
											begin
												case i of 
													1:	write('Green    ');
													2:	write('Dark Blue ');
													3:	write('Red      ');
													4:	write('Yellow   ');
													5:	write('Orange   ');
													6:	write('Brown    ');
													7:	write('Light Blue ');
													8:	write('Purple   ');
													9:	write('Utility  ');
													10:	write('Railroad ');
												end;
												j := j + 1;
												fullprop[j] := i;
											end;
											
										repeat	
											if j = 0 then
											begin
												writeln('You do not have full property to add Houses');
												delay(1000);
												action := action + 1;
												cardNo[pNo] := cardNo[pNo] + 1;
												card[pNo, cardNo[pNo]] := 8;
											end
											else
											begin
												gotoxy(5 + 9 * pointer2, 2);
													write('v');
														
												repeat
													ch2 := ReadKey;
													If ord(ch)=0 then
														ch2:=readkey; 
												until ord(ch2) in [75,77,32];
												
												case ch2 of
													#75:	begin									//left
																clrscr; pointer2 := (pointer2 + j - 1) mod j;
															end;
													#77:	begin									//right
																clrscr;	pointer2 := (pointer2 + 1) mod j;
															end;
													#32:	house[pNo, fullprop[pointer2 + 1]] := house[pNo, fullprop[pointer2 + 1]] + 3;
												end;
											end;
										until ch2 = #32;	
									end;
								9:	begin																										//Hotel
										pointer2 := 0;	j := 0;
										
										clrscr;
										writeln('Arrow key to select, space to comfirm the property you want to add a hotel:');
										writeln;
										
										for i := 1 to 10 do
											if properties[pNo, i] = propmax[i] then
											begin
												case i of 
													1:	write('Green    ');
													2:	write('Dark Blue ');
													3:	write('Red      ');
													4:	write('Yellow   ');
													5:	write('Orange   ');
													6:	write('Brown    ');
													7:	write('Light Blue ');
													8:	write('Purple   ');
													9:	write('Utility  ');
													10:	write('Railroad ');
												end;
												j := j + 1;
												fullprop[j] := i;
											end;
											
										repeat
											if j = 0 then
											begin
												writeln('You do not have full property to add Hotels');
												delay(1000);
												action := action + 1;
												cardNo[pNo] := cardNo[pNo] + 1;
												card[pNo, cardNo[pNo]] := 9;
											end
											else
											begin
												gotoxy(5 + 9 * pointer2, 2);
													write('v');
														
												repeat
													ch2 := ReadKey;
													If ord(ch)=0 then
														ch2:=readkey; 
												until ord(ch2) in [75,77,32];
												
												case ch2 of
													#75:	begin									//left
																clrscr; pointer2 := (pointer2 + j - 1) mod j;
															end;
													#77:	begin									//right
																clrscr;	pointer2 := (pointer2 + 1) mod j;
															end;
													#32:	hotel[pNo, fullprop[pointer2 + 1]] := hotel[pNo, fullprop[pointer2 + 1]] + 4;
												end;
											end;
										until ch2 = #32;	
									end;
								10: double := double * 2;
								11..16: begin																			//rent
											pointer2 := 0;	target := 0;
											
											if (card[pNo, pointer + 1] = 16) and (target = 0) then
												begin
													clrscr;
													write('Enter your target: ');
													readln(target);
													clrscr;
												end;
											writeln('Arrow key to select, space to comfirm the type you want:');
											writeln;
												
											case card[pNo, pointer + 1] of
												11: writeln('Purple       Orange');
												12: writeln('Utility      Railroad');
												13: writeln('Dark Blue    Green');
												14: writeln('Light BLue   Brown');
												15: writeln('Red          Yellow');
												16: writeln('Green    Dark Blue Red      Yellow   Orange   Brown    Light BLue Purple   Utility  Railroad ');
											end;
												
											repeat	
												gotoxy(5 + 9 * pointer2, 2);
												write('v');
												
												repeat
													ch2 := ReadKey;
													If ord(ch)=0 then
														ch2:=readkey; 
												until ord(ch2) in [75,77,32];
																										
												if card[pNo, pointer + 1] = 16 then
													case ch2 of
														#75: 	begin									//left
																	gotoxy(5 + 9 * pointer2, 2);
																	write(' ');
																	pointer2 := (pointer2 + 9) mod 10;
																end;	
														#77:	begin									//right
																	gotoxy(5 + 9 * pointer2, 2);
																	write(' ');
																	pointer2 := (pointer2 + 1) mod 10;
																end;
														#32:	begin
																	propchoice := pointer2 + 1;
																	value := 0;
																	case propchoice of
																		1:	case properties[pNo, propchoice] of
																				1:	value := 2;
																				2:	value := 4;
																				3:	value := 7;
																			end;
																		2:	case properties[pNo, propchoice] of
																				1:	value := 3;
																				2:	value := 8;
																			end;
																		3:	case properties[pNo, propchoice] of
																				1:	value := 2;
																				2:	value := 3;
																				3:	value := 6;
																			end;
																		4:	case properties[pNo, propchoice] of
																				1:	value := 2;
																				2:	value := 4;
																				3:	value := 6;
																			end;
																		5:	case properties[pNo, propchoice] of
																				1:	value := 1;
																				2:	value := 3;
																				3:	value := 5;
																			end;
																		6:	case properties[pNo, propchoice] of
																				1:	value := 1;
																				2:	value := 2;
																			end;
																		7:	case properties[pNo, propchoice] of
																				1:	value := 1;
																				2:	value := 2;
																				3:	value := 3;
																			end;
																		8:	case properties[pNo, propchoice] of
																				1:	value := 1;
																				2:	value := 2;
																				3:	value := 4;
																			end;
																		9:	case properties[pNo, propchoice] of
																				1:	value := 1;
																				2:	value := 2;
																			end;
																		10:	case properties[pNo, propchoice] of
																				1:	value := 1;
																				2:	value := 2;
																				3:	value := 3;
																				4:	value := 4;
																			end;
																	end;
																	if (value + house[pNo, propchoice] + hotel[pNo, propchoice]) > 0 then 
																	begin
//																		writeln((value + house[pNo, propchoice] + hotel[pNo, propchoice])*double);
//																		readln;
																		pay(pNo, (value + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, target, money, haveNo, denied);
																	end
																	else
																	begin
																		clrscr;
																		writeln('You do not have that property');
																		delay(500);
																		action := action + 1;
																		cardNo[pNo] := cardNo[pNo] + 1;
																		card[pNo, cardNo[pNo]] := card[pNo, pointer + 1];
																	end;
																	double := 1;
																end;
													end
												else
												begin
													case ch2 of
														#75, #77:	begin
																		gotoxy(5 + 9 * pointer2, 2);
																		write(' ');
																		pointer2 := (pointer2 + 1) mod 2;
	//																	gotoxy(10,10);
	//																	writeln(pointer2);
																	end;
														#32:		begin
																		case card[pNo, pointer + 1] of
																			11: if pointer2 = 0 then
																					propchoice := 8
																				else
																					propchoice := 5;
																			12: if pointer2 = 0 then
																					propchoice := 9
																				else
																					propchoice := 10;
																			13: if pointer2 = 0 then
																					propchoice := 2
																				else
																					propchoice := 1;
																			14: if pointer2 = 0 then
																					propchoice := 7
																				else
																					propchoice := 6;
																			15: if pointer2 = 0 then
																					propchoice := 3
																				else
																					propchoice := 4;
																		end;
																		if (value + house[pNo, propchoice] + hotel[pNo, propchoice]) > 0 then 
																			case propchoice of
																				1:	case properties[pNo, propchoice] of
																						1:	pay(pNo, (2 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						2:	pay(pNo, (4 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						3:	pay(pNo, (7 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																					end;
																				2:	case properties[pNo, propchoice] of
																						1:	pay(pNo, (3 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						2:	pay(pNo, (8 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																					end;
																				3:	case properties[pNo, propchoice] of
																						1:	pay(pNo, (2 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						2:	pay(pNo, (3 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						3:	pay(pNo, (6 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																					end;
																				4:	case properties[pNo, propchoice] of
																						1:	pay(pNo, (2 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						2:	pay(pNo, (4 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						3:	pay(pNo, (6 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																					end;
																				5:	case properties[pNo, propchoice] of
																						1:	pay(pNo, (1 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						2:	pay(pNo, (3 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						3:	pay(pNo, (5 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																					end;
																				6:	case properties[pNo, propchoice] of
																						1:	pay(pNo, (1 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						2:	pay(pNo, (2 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																					end;
																				7:	case properties[pNo, propchoice] of
																						1:	pay(pNo, (1 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						2:	pay(pNo, (2 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						3:	pay(pNo, (3 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																					end;
																				8:	case properties[pNo, propchoice] of
																						1:	pay(pNo, (1 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						2:	pay(pNo, (2 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						3:	pay(pNo, (4 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																					end;
																				9:	case properties[pNo, propchoice] of
																						1:	pay(pNo, (1 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						2:	pay(pNo, (2 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																					end;
																				10:	case properties[pNo, propchoice] of
																						1:	pay(pNo, (1 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						2:	pay(pNo, (2 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						3:	pay(pNo, (3 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																						4:	pay(pNo, (4 + house[pNo, propchoice] + hotel[pNo, propchoice]) * double, 5, money, haveNo, denied);
																					end;
																			end
																		else
																	begin
																		clrscr;
																		writeln('You do not have that property');
																		delay(500);
																		action := action + 1;
																		cardNo[pNo] := cardNo[pNo] + 1;
																		card[pNo, cardNo[pNo]] := card[pNo, pointer + 1];
																	end;
																		double := 1;
																	end;
													end;
												end;												
											until ch2 = #32;
										end;										
								17..34:	begin																			//property
											if (card[pNo, pointer + 1] < 35) and (card[pNo, pointer + 1] > 26) then
											begin
												pointer2 := 0;
												
												gotoxy(1,1);
												writeln('Arrow key to select, space to comfirm the type you want:');
												writeln;
													
												case card[pNo, pointer + 1] of
													27: writeln('Purple       Orange');
													28: writeln('Light Blue   Brown');
													29: writeln('Light Blue   RailRoad');
													30: writeln('Dark Blue    Green');
													31: writeln('RailRoad     Green');
													32: writeln('Red          Yellow');
													33: writeln('Utility      Railroad');
													34: writeln('Green    Dark Blue Red      Yellow   Orange   Brown    Light Blue Purple   Utility  Railroad ');
												end;
												
												repeat	
													gotoxy(4 + 9 * pointer2, 2);
													write('v');
													
													repeat
														ch2 := ReadKey;
														If ord(ch)=0 then
															ch2:=readkey; 
													until ord(ch2) in [75,77,32];
															
													if card[pNo, pointer + 1] = 34 then
														case ch2 of
															#75: 	begin									//left
																		gotoxy(4 + 9 * pointer2, 2);
																		write(' ');
																		pointer2 := (pointer2 + 9) mod 10;
																	end;
															#77:	begin									//right
																		gotoxy(4 + 9 * pointer2, 2);
																		write(' ');
																		pointer2 := (pointer2 + 1) mod 10;
																	end;
															#32:	begin
																		propchoice := pointer2 + 1;
																	end;
														end
													else
													begin
														case ch2 of
															#75, #77:	begin
																			gotoxy(4 + 9 * pointer2, 2);
																			write(' '); 
																			pointer2 := (pointer2 + 1) mod 2;
	//																		gotoxy(10,10);
	//																		writeln(pointer2);
																		end;
															#32:		begin
																			case card[pNo, pointer + 1] of
																				27: if pointer2 = 0 then
																						propchoice := 8
																					else
																						propchoice := 5;
																				28: if pointer2 = 0 then
																						propchoice := 7
																					else
																						propchoice := 6;
																				29: if pointer2 = 0 then
																						propchoice := 7
																					else
																						propchoice := 10;
																				30: if pointer2 = 0 then
																						propchoice := 2
																					else
																						propchoice := 1;
																				31: if pointer2 = 0 then
																						propchoice := 10
																					else
																						propchoice := 1;
																				32: if pointer2 = 0 then
																						propchoice := 3
																					else
																						propchoice := 4;
																				33: if pointer2 = 0 then
																						propchoice := 9
																					else
																						propchoice := 10;
																			end;
																		end;
														end;
													end;												
												until ch2 = #32;
											end
											else
												propchoice := card[pNo, pointer + 1] - 16;
												
											if properties[pNo, propchoice] < propmax[propchoice] then
                                            begin
												properties[pNo, propchoice] := properties[pNo, propchoice] + 1;
//												writeln(properties[pNo, propchoice]);	readln;
                                            end
											else
											begin
												writeln('You have reach the max no. of that property.');
												writeln('Maybe you can keep it.');
												writeln('BTW you can add a house or hotel to the set.');
												delay(5000);
												action := action + 1;
												cardNo[pNo] := cardNo[pNo] + 1;
												card[pNo, cardNo[pNo]] := card[pNo, pointer + 1];
											end;
										end;
								35:	begin																			//10M
										money[1] := pNo;
									end;
								36: begin																			//5M
										i := 0;
										repeat
											if money[2 + i] = 0 then
												money[2 + i] := pNo;
											i := i + 1;
										until money[1 + i] = pNo;
									end;
								37:	begin																			//4M
										i := 0;
										repeat
											if money[4 + i] = 0 then
												money[4 + i] := pNo;
											i := i + 1;
										until money[3 + i] = pNo;
									end;
								38:	begin																			//3M
										i := 0;
										repeat
											if money[7 + i] = 0 then
												money[7 + i] := pNo;
											i := i + 1;
										until money[6 + i] = pNo;
									end;
								39:	begin																			//2M
										i := 0;
										repeat
											if money[10 + i] = 0 then
												money[10 + i] := pNo;
											i := i + 1;
										until money[9 + i] = pNo;
									end;
								40:	begin																			//1M
										i := 0;
										repeat
											if money[15 + i] = 0 then
												money[15 + i] := pNo;
											i := i + 1;
										until money[14 + i] = pNo;
									end;
							end;
							
							cardNo[pNo] := cardNo[pNo] - 1;
							
							i := pointer;
							while i <> cardNo[pNo] do
							begin
//								numtotext(card[pNo, i + 1]); readln;
								card[pNo, i + 1] := card[pNo, i + 2];
//								numtotext(card[pNo, i + 1]); readln;
								i := i + 1;
							end;
							
							pointer := 0;
							action := action + 1;
							
							clrscr;
						end;
			end;		
		
			display(pNo, card, cardNo, money, properties, propmax, house, hotel);
			
			case pNo of
				1:	if pointer < 6 then
						gotoxy(2 + 4 * pointer, 4)
					else
						gotoxy(2 + 4 * (pointer - 6), 6);
						
				2:	if pointer < 6 then
						gotoxy(71 +	4 * pointer, 4)
					else
						gotoxy(71 +	4 * (pointer - 6), 6);
						
				3:	if pointer < 6 then
						gotoxy(71 + 4 * pointer, 20)
					else
						gotoxy(71 + 4 * (pointer - 6), 22);
						
				4:	if pointer < 6 then
						gotoxy(2 + 4 * pointer, 20)
					else
						gotoxy(2 + 4 * (pointer - 6), 22);
			end;	
			
			write('v');
//			write(pointer);
		
		until (action = 3) or (ord(ch) = 13);
		
		pointer := 0; double := 1;
		
		while cardNo[pNo] > 7 do	
		begin			
			repeat
				ch := ReadKey;
				If ord(ch)=0 then
					ch:=readkey; 
			until ord(ch) in [75,77,72,80,105,32];
					
			case ch of
				#75: 	begin									//left
							clrscr; pointer := (pointer + cardNo[pNo] - 1) mod cardNo[pNo];
						end;
				#77:	begin									//right
							clrscr;	pointer := (pointer + 1) mod cardNo[pNo];
						end;
//				#72, #80:
				#105:	begin									//i (info)
							clrscr;			
							info(card[pNo, pointer + 1]);
							readln;
							clrscr;
						end;
				#32:	begin									//  (space)
							clrscr;
							
							cardNo[pNo] := cardNo[pNo] - 1;
							
							i := pointer;
							while i <> cardNo[pNo] do
							begin
//								numtotext(card[pNo, i + 1]); readln;
								card[pNo, i + 1] := card[pNo, i + 2];
//								numtotext(card[pNo, i + 1]); readln;
								i := i + 1;
							end;
							
							pointer := 0;
							
							clrscr;
						end;
			end;
			
			display(pNo, card, cardNo, money, properties, propmax, house, hotel);
			
			case pNo of
				1:	if pointer < 6 then
						gotoxy(2 + 4 * pointer, 4)
					else
						gotoxy(2 + 4 * (pointer - 6), 6);
						
				2:	if pointer < 6 then
						gotoxy(71 +	4 * pointer, 4)
					else
						gotoxy(71 +	4 * (pointer - 6), 6);
						
				3:	if pointer < 6 then
						gotoxy(71 + 4 * pointer, 20)
					else
						gotoxy(71 + 4 * (pointer - 6), 22);
						
				4:	if pointer < 6 then
						gotoxy(2 + 4 * pointer, 20)
					else
						gotoxy(2 + 4 * (pointer - 6), 22);
			end;	
			
			write('v');
		end;
		
		for i := 1 to 4 do
			for j := 1 to 10 do
				if (properties[i, j] = propmax[j]) and (complete[i,j] = 0) then
				begin
					complete[i, j] := 1;
					win[i] := win[i] + 1;
				end;
		
	until (win[1] = 3) or (win[2] = 3) or (win[3] = 3) or (win[4] = 3);	
	
	clrscr;	writeln('player ', pNo, ' win');	readln;
end;

procedure t_control;
begin
	writeln('Left/Right arrow to select cards.');
	writeln('Spacebar to use the selected card.');
	writeln('Enter to pass to next player.');
	writeln('Press i for more information on the selected card.');
	writeln;
	writeln('Press enter to return...');
	readln;
	clrscr;
	writeln('  Control');
	writeln('  Game steps');
	writeln('  Card types');
	writeln('  Usage of cards');
	writeln('  Return');
end;

procedure t_gamestep;
begin
	writeln('Decide who should go first (player 1 first, player 2 second, etc.).');
	writeln('Each player must take 2 cards when their turn starts. If a player has no cards, draw 5 cards instead.');
	writeln;
	writeln('Each player can do (put down) up to 3 actions (shown below) each turn:');
	writeln(' - Put money/action cards into the bank.');
	writeln(' - Use action cards to take money, even properties from your rivals.');
	writeln(' - Lay out the properties.');
	writeln;
	writeln('If your rival(s) request you to pay money you can only pay in cash.');
	writeln('If you don''t have any cash in front of you, you don''t have to pay any cards on your hand.');
	writeln('Change is not given if you overpay.');
	writeln;
	writeln('Upon finishing your turn, if you have more than 7 cards in your hand you must discard until only 7 cards in your hand.');
	writeln('You may put a house, then a hotel on a property full set if your have one, except Railroads and Utilities.');
	writeln;
	writeln('A player wins when they have 3 sets of different colored properties on his turn.');
	writeln('This means that there is only one winner for any one game.');
	writeln;
	writeln('Press enter to return...');
	readln;
	clrscr;
	writeln('  Control');
	writeln('  Game steps');
	writeln('  Card types');
	writeln('  Usage of cards');
	writeln('  Return');
end;

procedure t_cardtype;
begin
	writeln('39 property cards, including:');
	writeln(' - 28 normal property cards,');
	writeln(' - 9 bi-colored property wild cards and');
	writeln(' - 2 multi-colored property wild cards.');
	writeln;
	writeln('47 action cards, including:');
	writeln(' - 10 color rent cards,');
	writeln(' - 3 any rent cards,');
	writeln(' - 2 Deal Breakers,');
	writeln(' - 3 Forced Deal cards,');
	writeln(' - 3 Sly Deal cards,');
	writeln(' - 3 Just Say No Cards,');
	writeln(' - 3 Debt Collectors,');
	writeln(' - 3 It''s My Birthday cards,');
	writeln(' - 2 Double the Rent cards,');
	writeln(' - 3 houses,');
	writeln(' - 2 hotels and');
	writeln(' - 10 Pass Go cards.');
	writeln;
	writeln('20 money cards, including:');
	writeln(' - 6 1M cards,');
	writeln(' - 5 2M cards,');
	writeln(' - 3 3M cards,');
	writeln(' - 3 4M cards,');
	writeln(' - 2 5M cards and');
	writeln(' - 1 10M card.');
	writeln;
	writeln('Press enter to return...');
	readln;
	clrscr;
	writeln('  Control');
	writeln('  Game steps');
	writeln('  Card types');
	writeln('  Usage of cards');
	writeln('  Return');
end;

procedure t_usage;
begin
	writeln('Normal property cards:');
	writeln(' - The critical material in this game.');
	writeln(' - The player who gets 3 full sets of different colored properties will be the winner.');
	writeln;
	writeln('Property wild cards:'); 
	writeln(' - Players can select the colors that they represent when they play this card,');
	writeln(' - but no changes are allowed after played.');
	writeln(' - propety wild cards include:');
	writeln('   Bi-colored property wild cards:');
	writeln('    - There are 2 colors on this kind of cards. They can substitute one of the colors shown on the card.');
	writeln('    - For example, a light blue+brown card can substitute either light blue or brown properties.');
	writeln('   Multi-colored property wild cards:');
	writeln('    - This kind of cards can substitute any colors of properties.');
	writeln('    - This kind of cards is also the exclusive kind of no valued card in this game.');
	writeln('    - While these cards can''t be used as payment, they can still be taken by action cards.');
	writeln;
	writeln('Rent cards:');
	writeln(' - You can collect rent of either one set of your properties from all rivals.');
	writeln(' - For example, if you play a red+yellow rent card, you can collect rent of red OR yellow properties from ALL rivals.');
	writeln(' - Even if one might collect 2 sets of properties of the same color, rent can still only be collected from one set.'); 
	writeln;
	writeln('Multi-colored rent cards:');
	writeln(' - The function of this kind of cards is collect rent of any one of the colors of your properties from one rival.');
	writeln;
	writeln('Double the Rent:');
	writeln(' - This kind of card should be played with rent cards. Doubles the rent chargeable.');
	writeln;
	writeln('Sly Deal:');
	writeln(' - You can steal a property card from one rival, but you can''t steal a property card in a full set of properties.');
	writeln;
	writeln('Forced Deal:');
	writeln(' - You can swap a property card with one rival, but you can''t swap a property card in a full set of properties.');
	writeln;
	writeln('Deal Breaker:');
	writeln(' - A powerful action card which let you steal a full set of property cards from one rival including buildings.');
	writeln;
	writeln('Just Say No:');
	writeln(' - Can be played at any time during the game to cancel the actions of a rival against the user who played this card.');
	writeln(' - Another Just Say No card can be played to cancel a previously played Just Say No card too, and so on.');
	writeln(' - These cards do not count if used during your turn.');
	writeln;
	writeln('Debt collector:');
	writeln(' - Collect 5M from one rival.');
	writeln;
	writeln('It''s My Birthday:');
	writeln(' - Collect 2M from all rivals.');
	writeln;
	writeln('Pass go:');
	writeln(' - Draw 2 extra cards.');
	writeln;
	writeln('House/Hotel:');
	writeln(' - Can be played on any full set of properties except railroads and utilities. Adds 3M/4M to the total rent.');
	writeln;
	writeln('Money cards:');
	writeln('Put it into your bank for paying fees (rents, debts, gifts) to your rivals.');
	writeln;
	writeln('Press enter to return...');
	readln;
	clrscr;
	writeln('  Control');
	writeln('  Game steps');
	writeln('  Card types');
	writeln('  Usage of cards');
	writeln('  Return');
end;

procedure tutorial;
var
	pointer: integer;
    ch: char;
	done: boolean;
begin
    pointer := 0;
	done := false;
	writeln('  Control');
	writeln('  Game steps');
	writeln('  Card types');
	writeln('  Usage of cards');
	writeln('  Return');
	
	repeat	
        gotoxy(1,1 + pointer);
        write('>');	

		repeat
			ch := ReadKey;
			If ord(ch)=0 then
				ch:=readkey; 
		until ord(ch) in [72,80,13];
			
		case ch of
			#72: 	begin
						gotoxy(1,1 + pointer);
						write(' ');	
						pointer := (pointer + 4) mod 5;
	//					writeln(pointer);
	//					writeln('up');
					end;
			#80:	begin
						gotoxy(1,1 + pointer);
						write(' ');	
						pointer := (pointer + 1) mod 5;
	//					writeln(pointer);
	//					writeln('down');
					end;
			#13:	begin
						clrscr;
						case pointer of
							0:	t_control;
                  			1:	t_gamestep;
							2:	t_cardtype;
							3:	t_usage;
							4:	done := true;
						end;
					end;
		end;
	until done;
end;

procedure option;
var
	pointer: integer;
    ch: char;
	done: boolean;
	opt: text;
begin
    pointer := 0;
	writeln('Up/Down arrow to choose, enter to select/edit');
	writeln;
	write('  Text color: ');
	case cur_textcolor of
		0 : writeln('Black               ');
		1 : writeln('Blue                ');
		2 : writeln('Green               ');
		3 : writeln('Cyan                ');
		4 : writeln('Red                 ');
		5 : writeln('Magenta             ');
		6 : writeln('Brown               ');
		7 : writeln('White               ');
		8 : writeln('Grey                ');
		9 : writeln('Light Blue          ');
		10 : writeln('Light Green         ');
		11 : writeln('Light Cyan          ');
		12 : writeln('Light Red           ');
		13 : writeln('Light Magenta       ');
		14 : writeln('Yellow              ');
		15 : writeln('High-intensity White');
	end;
	writeln;
	writeln('  return');
	
	repeat	
		gotoxy(1,3 + 2 * pointer);
        write('>');	
		
		repeat
			ch := ReadKey;
			If ord(ch)=0 then
				ch:=readkey; 
		until ord(ch) in [72,80,13];
			
		case ch of
			#72: 	begin
						gotoxy(1,3 + 2 * pointer);
						write(' ');	
						pointer := (pointer + 1) mod 2;						
					end;
			#80:	begin
						gotoxy(1,3 + 2 * pointer);
						write(' ');	
						pointer := (pointer + 1) mod 2;
					end;
			#13:	begin
						case pointer of
							0:	begin
									gotoxy(15,3);
									cur_textcolor := (cur_textcolor + 1) mod 16;
									textcolor(cur_textcolor);
									case cur_textcolor of
										0 : writeln('Black               ');
										1 : writeln('Blue                ');
										2 : writeln('Green               ');
										3 : writeln('Cyan                ');
										4 : writeln('Red                 ');
										5 : writeln('Magenta             ');
										6 : writeln('Brown               ');
										7 : writeln('White               ');
										8 : writeln('Grey                ');
										9 : writeln('Light Blue          ');
										10 : writeln('Light Green         ');
										11 : writeln('Light Cyan          ');
										12 : writeln('Light Red           ');
										13 : writeln('Light Magenta       ');
										14 : writeln('Yellow              ');
										15 : writeln('High-intensity White');
									end;
								end;
							1:	begin
									assign(opt, opt_addr);
									rewrite(opt);
									writeln(opt, 'Text color: (Default: white(15))');
									writeln(opt, cur_textcolor);
									close(opt);
									done := true;
								end;
                        end;
					end;
		end;
	until done;
	clrscr;
end;

var
	outcome: byte;	init: boolean;

begin
	GenOption;
    GenList;
	repeat
		init := true;
//		writeln('Hi');
//		readln;
		LoadOption;
//		writeln('Hi');
//		readln;		
		textcolor(cur_textcolor);
		MainMenu(init,outcome);
		clrscr;
		case outcome of
			0:	begin 
					clrscr;
					local;
					clrscr;
				end;
			1: 	begin 
					writeln('Update required for Online Multiplayer.');
					delay(1000);
					clrscr;
					init := true;
				end;
			2: 	begin 
					clrscr;
					tutorial;
					init := true;
				end;
			3: 	begin 
					clrscr;
					option;
					init := true;
				end;
			4:	begin 
					writeln('Bye.');
					delay(1000);
				end;
		end;
	until outcome = 4
end.
