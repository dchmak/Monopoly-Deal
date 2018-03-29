uses crt;

type
	decktype = array[1..40,1..2] of byte; {current, max}
	cardtype = array[1..4,1..12] of integer; {player, hand}
	propertytype = array[1..4, 1..10] of byte; {player, no. of certain properties}
	propmaxtype = array[1..10] of byte;
	cardNotype = array[1..4] of integer;
	moneytype = array[1..20] of byte;	{1-20: types of money, 21: how many types of money}
		
procedure MainMenu(init: boolean ; var outcome: byte);
var
	pointer: byte;
	done: boolean;
	ch: char;
begin
//	writeln(pointer);	writeln(outcome);	readln;
	done := false;
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
							clrscr;	pointer := (pointer + 4) mod 5;
	//						writeln(pointer);
	//						writeln('up');
						end;
				#80 :	begin
							clrscr;	pointer := (pointer + 1) mod 5;
	//						writeln(pointer);
	//						writeln('down');
						end;
			end;
		end;

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
		writeln('Version Alpha 1.0.10                                                  By Goggle');

        
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
var
	cardsf: text;
	i: integer;
	sf: string[3];
begin
	assign(cardsf, 'U:\ICTSBA\cardshortform.txt');
	reset(cardsf);
	
	for i := 1 to cardNum - 1 do
		readln(cardsf);
		
	readln(cardsf, sf);
	write(sf:3, ' ');
	
	close(cardsf);
end;

procedure display(pNo: integer; var card: cardtype; var cardNo: cardNotype; var money: moneytype; var properties: propertytype; var propmax: propmaxtype);
var
	i, j, k, m: integer;
	info: string;
	cardinfo: text;
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

		assign(cardinfo, 'U:\ICTSBA\cardinfo.txt');	
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
			reset(cardinfo);
			for k := 1 to 3*(j+15) do
				readln(cardinfo);
			readln(cardinfo, info);
			write(info, ': ', properties[i, j]);
			if properties[i, j] = propmax[j] then
				write(' (full)');		
			close(cardinfo);
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
var
	cardinfo: text;
	i: integer;
	info: string;
begin
//	writeln(selCard:5);
	
	assign(cardinfo, 'U:\ICTSBA\cardinfo.txt');
	reset(cardinfo);
	
	for i := 1 to 3*(selCard-1) do
		readln(cardinfo);
		
	readln(cardinfo, info);
	writeln('Name: ', info);
	writeln;
	readln(cardinfo, info);
	writeln('Value: ', info);
	writeln;
	readln(cardinfo, info);
	writeln('Detail info: ', info);	
	writeln;
	write('Press enter to return.');
	
	close(cardinfo);
end;

procedure pay(collector: byte; value: byte; target: byte; var money: moneytype); //target: 5 = all
var
	i, j, k, count, count2, pointer: integer;
	ch: char;
	a: array[1..20,1..2] of byte;
begin
	if target <> 5 then
	begin
		clrscr;
		
		for i := 1 to 2 do
			for j := 1 to 20 do
				a[j, i] := 0;
				
		i := 0; count := 0;
		
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
		
		count2 := 0;
		
		if count >= value then				
			repeat
				writeln('Player ', target, ', please pay ', value,'M.');
				writeln;	writeln;
				for j := 1 to i do
					write(a[j,1],'M ');
					
				writeln;
				writeln;
				writeln('Paid: ',count2);
					
				pointer := 0;
				gotoxy(1 + 3 * pointer, 3);
				write('v');
				
				repeat
					ch := readkey;
					If ord(ch)=0 then
						ch := readkey; 
				until ord(ch) in [75,77,32];
						
				case ch of
					#75: 	begin									//left
								clrscr; pointer := (pointer + i - 1) mod i;
							end;
					#77:	begin									//right
								clrscr;	pointer := (pointer + 1) mod i;
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
			until count2 >= value;
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

                i := 0; count := 0;
				
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
				
				count2 := 0;
				
				if count >= value then
					repeat
						clrscr;
						writeln('Player ', k, ', please pay ', value,'M.');
						writeln;	writeln;
						for j := 1 to i do
							write(a[j,1],'M ');
							
						writeln;	writeln;
						writeln('Paid: ',count2);
							
						pointer := 0;
						gotoxy(1 + 3 * pointer, 3);
						write('v');							
						
						repeat
							ch := readkey;
							If ord(ch)=0 then
								ch := readkey; 
						until ord(ch) in [75,77,32];
								
						case ch of
							#75: 	begin									//left
										clrscr; pointer := (pointer + i - 1) mod i;
									end;
							#77:	begin									//right
										clrscr;	pointer := (pointer + 1) mod i;
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
					until count2 >= value;
			end;
	end
end;

procedure takeSet (user, target: byte; var properties: propertytype; var propmax: propmaxtype);
var
	i, j, pointer: integer;
    ch: char;
	a: array[1..10] of integer;
begin
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
		if j = 0 then
		begin
			clrscr;
			writeln('No property to steal.');
			delay(5000);
		end
		else
		begin
		
			pointer := 0;
			gotoxy(5 + 3 * pointer, 3);
			write('v');							
			
			repeat
				ch := readkey;
				If ord(ch)=0 then
					ch := readkey; 
			until ord(ch) in [75,77,32];
									
			case ch of
				#75: 	begin									//left
							clrscr; pointer := (pointer + j - 1) mod j;
						end;
				#77:	begin									//right
							clrscr;	pointer := (pointer + 1) mod j;
						end;
				#32:	begin
							properties[target, a[pointer + 1]] := properties[target, a[pointer + 1]] - propmax[pointer + 1];
							properties[user, a[pointer + 1]] := properties[user, a[pointer + 1]] + propmax[pointer + 1];
						end;
			end;
		end;
	until ch = #32;
end;

procedure takeProp (user, target: byte; var properties: propertytype);
var
	i, j, pointer: integer;
    ch: char;
	a: array[1..10] of integer;
begin
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
		if j = 0 then
		begin
			clrscr;
			writeln('No property to steal.');
			delay(5000);
		end
		else
		begin
		
			pointer := 0;
			gotoxy(5 + 3 * pointer, 3);
			write('v');							
			
			repeat
				ch := readkey;
				If ord(ch)=0 then
					ch := readkey; 
			until ord(ch) in [75,77,32];
									
			case ch of
				#75: 	begin									//left
							clrscr; pointer := (pointer + j - 1) mod j;
						end;
				#77:	begin									//right
							clrscr;	pointer := (pointer + 1) mod j;
						end;
				#32:	begin
							properties[target, a[pointer + 1]] := properties[target, a[pointer + 1]] - 1;
							properties[user, a[pointer + 1]] := properties[user, a[pointer + 1]] + 1;
						end;
			end;
		end;
	until ch = #32;
end;


procedure giveProp (user, target: byte; var properties: propertytype);
var
	i, j, pointer: integer;
    ch: char;
	a: array[1..10] of integer;
begin
	repeat
		clrscr;
		writeln('Choose the color of property you want to take from player ', target);
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
		
			pointer := 0;
			gotoxy(5 + 3 * pointer, 3);
			write('v');							
			
			repeat
				ch := readkey;
				If ord(ch)=0 then
					ch := readkey; 
			until ord(ch) in [75,77,32];
									
			case ch of
				#75: 	begin									//left
							clrscr; pointer := (pointer + j - 1) mod j;
						end;
				#77:	begin									//right
							clrscr;	pointer := (pointer + 1) mod j;
						end;
				#32:	begin
							properties[user, a[pointer + 1]] := properties[user, a[pointer + 1]] - 1;
							properties[target, a[pointer + 1]] := properties[target, a[pointer + 1]] + 1;
						end;
			end;
		end;
	until ch = #32;
end;


procedure local;
var
	no: boolean;
	deck: decktype;
	card: cardtype;
	cardNo: cardNotype;
	properties: propertytype;
	propmax: propmaxtype;
	money: moneytype;
	i, j, pNo, pointer, pointer2, action, propchoice, target, value, double: integer;
	cardlist: text;
	complete: array[1..4,1..10] of byte;
	win: array[1..4] of byte;
	ch, ch2: char;
begin
	assign(cardlist, 'U:\ICTSBA\cardlist.txt');						
	reset(cardlist);
	
	for i := 1 to 40 do											//load max no. of each card
	begin
		read(cardlist, deck[i,2]);
		readln(cardlist);
	end;
	close(cardlist);
		
{	for i := 1 to 40 do
	begin
		writeln(deck[i,2]);
	end;
	readln;}	
	
	for i := 1 to 10 do
		propmax[i] := deck[i + 16, 2];
	
	for i := 1 to 40 do											//reset deck
		deck[i,1] := 0;
	
	for i := 1 to 4 do											//reset player's hand, properties and money
	begin
		for j := 1 to 12 do
			card[i,j] := 0;
		for j := 1 to 10 do
			properties[i, j] := 0;
		cardNo[i] := 0;
		win[i] := 0;
	end;
	
	for j := 1 to 20 do
		money[j] := 0;
	
	for i := 1 to 4 do 
		for j := 1 to 10 do
			complete[i,j] := 0;
			
	
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
		
		display(pNo, card, cardNo, money, properties, propmax);

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
			until ord(ch) in [75,77,72,80,13,105,32];
					
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
							case card[pNo, pointer + 1] of
								1:	begin																				//Deal Breaker
										clrscr;
										write('Enter your target: ');
										readln(target);
										takeSet(pNo, target, properties, propmax);
									end;
								3:	begin																				//Sly Deal
										clrscr;
										write('Enter your target: ');
										readln(target);
										takeProp(pNo, target, properties);
                                    end;
								4:	begin																				//Sly Deal
										clrscr;
										write('Enter your target: ');
										readln(target);
										takeProp(pNo, target, properties);
										giveProp(pNo, target, properties);
                                    end;
								5:	begin																				//Debt Collector
										clrscr;
										write('Enter your target: ');
										readln(target);
										pay(pNo, 5, target, money);
									end;
								6:	pay(pNo, 2, 5, money);																//It's my birthday
								7:	draw(pNo, card, cardNo, deck, 2);													//Pass Go
								10: double := double * 2;
								11..16: begin																			//rent
											pointer2 := 0;	target := 0;
											repeat
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
																	clrscr; pointer2 := (pointer2 + 9) mod 10;
																end;	
														#77:	begin									//right
																	clrscr;	pointer2 := (pointer2 + 1) mod 10;
																end;
														#32:	begin
																	propchoice := pointer2 + 1;
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
																	pay(pNo, value * double, target, money);
																	double := 1;
																end;
													end
												else
												begin
													case ch2 of
														#75, #77:	begin
																		clrscr; pointer2 := (pointer2 + 1) mod 2;
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
																		case propchoice of
																			1:	case properties[pNo, propchoice] of
																					1:	pay(pNo, 2, 5, money);
																					2:	pay(pNo, 4, 5, money);
																					3:	pay(pNo, 7, 5, money);
																				end;
																			2:	case properties[pNo, propchoice] of
																					1:	pay(pNo, 3, 5, money);
																					2:	pay(pNo, 8, 5, money);
																				end;
																			3:	case properties[pNo, propchoice] of
																					1:	pay(pNo, 2, 5, money);
																					2:	pay(pNo, 3, 5, money);
																					3:	pay(pNo, 6, 5, money);
																				end;
																			4:	case properties[pNo, propchoice] of
																					1:	pay(pNo, 2, 5, money);
																					2:	pay(pNo, 4, 5, money);
																					3:	pay(pNo, 6, 5, money);
																				end;
																			5:	case properties[pNo, propchoice] of
																					1:	pay(pNo, 1, 5, money);
																					2:	pay(pNo, 3, 5, money);
																					3:	pay(pNo, 5, 5, money);
																				end;
																			6:	case properties[pNo, propchoice] of
																					1:	pay(pNo, 1, 5, money);
																					2:	pay(pNo, 2, 5, money);
																				end;
																			7:	case properties[pNo, propchoice] of
																					1:	pay(pNo, 1, 5, money);
																					2:	pay(pNo, 2, 5, money);
																					3:	pay(pNo, 3, 5, money);
																				end;
																			8:	case properties[pNo, propchoice] of
																					1:	pay(pNo, 1, 5, money);
																					2:	pay(pNo, 2, 5, money);
																					3:	pay(pNo, 4, 5, money);
																				end;
																			9:	case properties[pNo, propchoice] of
																					1:	pay(pNo, 1, 5, money);
																					2:	pay(pNo, 2, 5, money);
																				end;
																			10:	case properties[pNo, propchoice] of
																					1:	pay(pNo, 1, 5, money);
																					2:	pay(pNo, 2, 5, money);
																					3:	pay(pNo, 3, 5, money);
																					4:	pay(pNo, 4, 5, money);
																				end;
																		end;
																	end;
													end;
												end;												
											until ch2 = #32;
										end;										
								17..34:	begin																			//property
											if (card[pNo, pointer + 1] < 35) and (card[pNo, pointer + 1] > 26) then
											begin
												pointer2 := 0;
												repeat
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
																		clrscr; pointer2 := (pointer2 + 9) mod 10;
																	end;
															#77:	begin									//right
																		clrscr;	pointer2 := (pointer2 + 1) mod 10;
																	end;
															#32:	begin
																		propchoice := pointer2 + 1;
																	end;
														end
													else
													begin
														case ch2 of
															#75, #77:	begin
																			clrscr; pointer2 := (pointer2 + 1) mod 2;
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
												writeln('Maybe you can keep it or use it as money.');
												writeln('BTW you can add a house or hotel to the set.');
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
		
			display(pNo, card, cardNo, money, properties, propmax);
			
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
			
			display(pNo, card, cardNo, money, properties, propmax);
			
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

var
	outcome: byte;	init: boolean;

begin
	repeat
		init := true;
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
					writeln('Update required for Tutorial.');
					delay(1000);
					clrscr;
					init := true;
				end;
			3: 	begin 
					writeln('Update required for Option.');
					delay(1000);
					clrscr;
					init := true;
				end;
			4:	begin 
					writeln('Bye.');
					delay(1000);
				end;
		end;
	until outcome = 4
end.
