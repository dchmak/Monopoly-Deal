uses crt;

type
	decktype = array[1..40,1..2] of byte; {current, max}
	cardtype = array[1..4,1..12] of integer; {player, hand}
	cardNotype = array[1..4] of integer;
	
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
		writeln('Version Alpha 1.0.3                                                  By Goggle');

        
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

procedure display(pNo: integer; var card: cardtype; var cardNo: cardNotype; var money: cardNotype);
var
	i, j: integer;
begin
	for i := 1 to 4 do
	begin		
		case i of
			1: 	begin
					gotoxy(1,3);
					writeln('Player 1   ', money[1],'M');
					gotoxy(1,5);
				end;
			2:  begin
					gotoxy(70,3);
					writeln('Player 2   ', money[2],'M');						
					gotoxy(70,5);
				end;
			3:	begin
					gotoxy(70,19);
					writeln('Player 3   ', money[3],'M');
					gotoxy(70,21);
				end;
			4:	begin	
					gotoxy(1,19);	
					writeln('Player 4   ', money[4],'M');
					gotoxy(1,21);
				end;		
	    end;		
		
		for j := 1 to cardNo[i] do
		begin
			if i <> pNo then
			begin	
				textbackground(7);
				write('   ');
				textbackground(0);
				write(' ');
			end
			else
				numtotext(card[i,j]);
		end;					
	end;
	gotoxy(40,10);
	writeln('i for more info,');
	gotoxy(32,11);
	writeln('(space) for using the selected card,');
	gotoxy(35,12);
	writeln('(enter) to go to next turn.');
end;

procedure info(pNo, selCard: integer; card: cardtype);
var
	cardinfo: text;
	i: integer;
	info: string;
begin
	//writeln(pNo:5, selCard:5, card[pNo,selCard+1]:5);
	
	assign(cardinfo, 'U:\ICTSBA\cardinfo.txt');
	reset(cardinfo);
	
	for i := 1 to 3*(card[pNo,selCard+1]-1) do
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

procedure local;
var
	deck: decktype;
	card: cardtype;
	cardNo, money: cardNotype;
	i, j, pNo, pointer: integer;
	cardlist: text;
	win: boolean;
	ch: char;
begin
	assign(cardlist, 'U:\ICTSBA\cardlist.txt');						
	reset(cardlist);
	
	for i := 1 to 40 do
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
	
	for i := 1 to 40 do											//reset deck
		deck[i,1] := 0;
	
	for i := 1 to 4 do											//reset player's hand and money
	begin
		for j := 1 to 12 do
			card[i,j] := 0;
		cardNo[i] := 0;
		money[i] := 0;
	end;
		
	win := false;
	
	randomize;

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
		
		display(pNo, card, cardNo, money);

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
		pointer := 0;
		repeat
			repeat
				ch := ReadKey;
				If ord(ch)=0 then
					ch:=readkey; 
			until ord(ch) in [75,77,13,73,32];
					
			case ch of
				#75: 	begin									//left
							clrscr; pointer := (pointer + cardNo[pNo] - 1) mod cardNo[pNo];
						end;
				#77:	begin									//right
							clrscr;	pointer := (pointer + 1) mod cardNo[pNo];
						end;
				#73:	begin									//i (info)
							clrscr; 
							info(pNo, pointer, card);
							readln;
							clrscr;
						end;
				#32:	begin									//  (space)
							clrscr; writeln('Update required for use card feature');
							delay(1000);
							clrscr;
						end;
			end;		
		
			display(pNo, card, cardNo, money);
			
			case pNo of
				1:	gotoxy(2  + 4 * pointer,4);
				2:	gotoxy(71 +	4 * pointer,4);
				3:	gotoxy(71 + 4 * pointer,20);
				4:	gotoxy(2  + 4 * pointer,20);
			end;	
			
			write('v');
		
		until ord(ch) = 13;
		
	until win;
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
