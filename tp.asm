.8086
.model	small
.stack	2048

DADOS	SEGMENT PARA 'DATA'
		POSy			db		10	; a linha pode ir de [1 .. 25]
		POSx			db		40	; POSx pode ir [1..80]	
	; :::::::::::::::::: Files in Memory ::::::::::::::::::
		map_editor		db		'./files/map_editor.txt',0
    ; :::::::::::::::::: Ficheiros em Memória ::::::::::::::::::

	; :::::::::::::::::: File Handles ::::::::::::::::::
		Erro_Open       db      'Erro ao tentar abrir o ficheiro$'
		Erro_Ler_Msg    db      'Erro ao tentar ler do ficheiro$'
		Erro_Close      db      'Erro ao tentar fechar o ficheiro$'
		msgErrorCreate	db	"Ocorreu um erro na criacao do ficheiro!$"
		msgErrorWrite	db	"Ocorreu um erro na escrita para ficheiro!$"
		msgErrorClose	db	"Ocorreu um erro no fecho do ficheiro!$"
		HandleFich      dw      0
		car_fich        db      ?
	; :::::::::::::::::: File Handles ::::::::::::::::::

	; :::::::::::::::::: Handles ::::::::::::::::::

		pontos			dw		0
		str_aux			db		10 dup('$')
	; :::::::::::::::::: Handles ::::::::::::::::::

	; :::::::::::::::::: Warnings ::::::::::::::::::
		Erro_Input		db		'WARNING: Input invalido (Press any key to continue...) $'
	; :::::::::::::::::: Warnings ::::::::::::::::::

	; :::::::::::::::::: Cobra Utils ::::::::::::::::::
		tam				db 		1	; tamanho da cobra, menos 1 (facilita o uso do vetor)
		snake_dir		db		620 dup(?) ; vetor de direçoes para cada "peça" da cobra
		head_x			db		?
		head_y			db		?	
		tail_x 			db		?
		tail_y			db		?
	; :::::::::::::::::: Cobra Utils ::::::::::::::::::

	; :::::::::::::::::: Views ::::::::::::::::::
				GameBoardView	db	"                          DANGER NOODLE                                       ",13,10
								db	"  ##################################################################          ",13,10
								db	"  ##                                                              ##          ",13,10  ; Limites
								db	"  ##                                                              ##          ",13,10	; x : 5 - 64
								db	"  ##                                                              ##          ",13,10	; y : 3 - 20
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##################################################################          ",13,10
								db	"            SCORE:                           LEVEL:                           ",13,10
								db	"                                                                             $",13,10

			MapEditor			db	"                             DANGER NOODLE                                    ",13,10
								db	"  ##################################################################          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##################################################################          ",13,10
								db	"            SCORE:                           LEVEL:                           ",13,10
								db	"                                                                             $",13,10
							
			StandardMapEditor	db	"                             DANGER NOODLE                                    ",13,10
								db	"  ##################################################################          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##################################################################          ",13,10
								db	"            SCORE:                           LEVEL:                           ",13,10
								db	"                                                                             $",13,10
								

			MainMenuView		db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db 	"      o---------------------------------------------------------------o      ",13,10
								db 	"      |      0       |     1      |       2       |     3     |   4   |      ",13,10
								db 	"      | How to play? |  New game  |   Show stats  |  Credits  |  Exit |      ",13,10
								db 	"      o---------------------------------------------------------------o      ",13,10
								db	"                                                                             ",13,10
								db 	"      Insert Option >                                                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10


	BonusChooseDifficultyView 	db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db  "                       o----------------------------o                        ",13,10
								db  "                       |   1  |     2      |    3   |                        ",13,10
								db 	"                       | Play | Edit Board |  Back  |                        ",13,10
								db 	"                       o----------------------------o                        ",13,10
								db	"                                                                             ",13,10
								db 	"      Insert Option >                                                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10

		ChooseDifficultyView 	db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db  "                   o-------------------------------------o                   ",13,10
								db  "                   |   1   |    2   |     3     |   4    |                   ",13,10
								db 	"                   | Slug  |  Hare  |  Cheetah  |  Back  |                   ",13,10
								db 	"                   o-------------------------------------o                   ",13,10
								db	"                                                                             ",13,10
								db 	"      Insert Option >                                                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10

				EditorMapMenu	db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db  "                       o---------------------------------o                   ",13,10
								db  "                       |      1     |      2      |   3  |                   ",13,10
								db 	"                       | New Editor | Load Editor | Back |                   ",13,10
								db 	"                       o---------------------------------o                   ",13,10
								db	"                                                                             ",13,10
								db 	"      Insert Option >                                                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10


			CreditsView			db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db 	"                        Implemented by:                                      ",13,10
								db	"                            > Andre Coelho   - 21270347                      ",13,10
								db 	"                            > Joaquim Santos - 21270351                      ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db 	"                    Press any key to get back to the main menu...            ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10


			StatsMenuView		db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                    o-----------------------------------o                    ",13,10
								db	"                    |       1        |    2    |   3    |                    ",13,10
								db	"                    |  Game history  |  Stats  |  Back  |                    ",13,10
								db 	"                    o-----------------------------------o                    ",13,10
								db	"                                                                             ",13,10
								db 	"      Insert Option >                                                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10

			GameHistoryView		db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                   > Game History                                            ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db 	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db 	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10



			StatsView 			db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                Stats:                                                       ",13,10
								db 	"                                                                             ",13,10								
								db	"                  > Nr. games:                                               ",13,10  ; (31, 17)
								db	"                  > Best play:                                               ",13,10  ; (31, 18)
								db 	"                  > Worst play:                                              ",13,10  ; (32, 19)
								db	"                  > Average play:                                            ",13,10  ; (34, 20)
								db	"                                                                             ",13,10
								db	"                      Press any key to get back to menu...                   ",13,10
								db	"                      (Debbug - needs to be implemented)                     ",13,10
								db	"                                                                            $",13,10


			HowToPlayView		db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                               < HOW TO PLAY >                               ",13,10
								db	"                                                                             ",13,10
								db	"                        LEFT ARROW      to move LEFT                         ",13,10
								db	"                        RIGHT ARROW     to move RIGHT                        ",13,10
								db	"                        DOWN ARROW      to move DOWN                         ",13,10
								db	"                        UP ARROW        to move UP                           ",13,10
								db	"                                                                             ",13,10
								db	"                    Press any key to get back to main menu...                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10


			newGameView			db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                o-----------------------------------------------o            ",13,10
								db	"                |       1       |       2       |       3       |            ",13,10
								db	"                |    Classic    |     Bonus     |  Back to menu |            ",13,10
								db	"                o-----------------------------------------------o            ",13,10
								db	"                                                                             ",13,10
								db 	"      Insert Option >                                                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10


		YouSureAboutThatView	db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                           Are you sure about that?                          ",13,10								
								db	"                                                                             ",13,10
								db	"             o---------o                                o---------o          ",13,10
								db	"             | 0 - yes |                                | 1 - no  |          ",13,10
								db	"             o---------o                                o---------o          ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10

				GameOverView	db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"      *****                                  /**                   /**       ",13,10
								db	"    **///**  ******   **********   *****    /**  ******   ****** ******      ",13,10
								db  "   /**  /** //////** //**//**//** **///**   /** **////** **//// ///**/       ",13,10
								db 	"    //******  *******  /** /** /**/*******   /**/**   /**//*****   /**       ",13,10
								db 	"     /////** **////**  /** /** /**/**////    /**/**   /** /////**  /**       ",13,10
								db  "      ***** //******** *** /** /**//******   ***//******  ******   //**      ",13,10
								db 	"    /////   //////// ///  //  //  //////   ///  //////  //////     //        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                         Do you wuant to play again?                         ",13,10
								db	"                                                                             ",13,10
								db	"             o---------o                                o---------o          ",13,10
								db	"             | 0 - yes |                                | 1 - no  |          ",13,10
								db	"             o---------o                                o---------o          ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10


				MapEditorHelp	db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                      		      Editor Help                                 ",13,10
								db	"                                                                             ",13,10
								db	"              - Use the ARROW KEYS to mouve the cursor around                ",13,10
								db	"                                                                             ",13,10
								db	"              - To change between '#' and ' ' use SPACE BAR                  ",13,10
								db	"                                                                             ",13,10
								db	"              - To save the file use ESC button                              ",13,10
								db	"                                                                             ",13,10
								db	"                          Press any key to go back...                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10
								



		slug_label		db		"SLUG$"
		hare_label		db		"HARE$"
		cheetah_label	db		"CHEETAH$"

		conta_MM		db		0
		conta_MV		db		0
		conta_RD		db		0
		game_id			db		000
		
		nr_games		db		"10$"
		best_play 		db 		"100$"
		average_play	db		"50$"
		worst_play		db		"20$"

		difficulty		db		? 	; (?) Multiplier para pontuação
		conta_maca		db		0

		nr_macas		db		0	
		nr_ratos		db		0
		rato_x			db 		?
		rato_y			db		?
		tp_vida			db		?
		rato_nasce		db		?

		POSya			db		5	; Posição anterior de y
		POSxa			db		10	; Posição anterior de x
		POSxPont		db		19
		POSyPont		db		23
		posxlevel		db 		52
		posylevel		db		23
		

		PASSA_T			dw		0
		PASSA_T_ant		dw		0
		direccao		db		3
		direccao_edita	db		0
		Centesimos		dw 		0
		FACTOR			db		100
		metade_FACTOR	db		?
		resto			db		0

		ultimo_num_aleat dw 	0
		maca			db		0

DADOS	ENDS

CODIGO	SEGMENT PARA 'CODE'
	ASSUME CS:CODIGO, DS:DADOS

;------------------------------------------------------------------------
; Colocar o cursor na posição posx, posy
;  > param: posx - coluna, posy - lina 
;------------------------------------------------------------------------
GOTO_XY		MACRO	POSX,POSY
			xor bx, bx
			xor	ax, ax
			xor	dx, dx
			MOV	AH,02H
			MOV	BH,0
			MOV	DL,POSX
			MOV	DH,POSY
			INT	10H
ENDM


; :::::::::::::::::: Imprimir Ficheiro para STDOUT ::::::::::::::::::
; author: Professor
Imp_Fich	PROC
;abre ficheiro
		call 	clear_screen
        mov     ah,3dh				; vamos abrir ficheiro para leitura 
        mov     al,0				; tipo de ficheiro
        int     21h					; abre para leitura 
        jc      erro_abrir			; pode aconter erro a abrir o ficheiro 
        mov     HandleFich,ax		; ax devolve o Handle para o ficheiro 
        jmp     ler_ciclo			; depois de abero vamos ler o ficheiro 

erro_abrir:
        mov     ah,09h
        lea     dx,Erro_Open
        int     21h
        jmp     sai

ler_ciclo:
        mov     ah,3fh				; indica que vai ser lido um ficheiro 
        mov     bx,HandleFich		; bx deve conter o Handle do ficheiro previamente aberto 
        mov     cx,1				; numero de bytes a ler 
        lea     dx,car_fich			; vai ler para o local de memoria apontado por dx (car_fich)
        int     21h					; faz efectivamente a leitura
	    jc	    erro_ler			; se carry é porque aconteceu um erro
	    cmp	    ax,0				; EOF?	verifica se já estamos no fim do ficheiro 
	    je	    fecha_ficheiro		; se EOF fecha o ficheiro 
        mov     ah,02h				; coloca o caracter no ecran
	    mov	    dl,car_fich			; este é o caracter a enviar para o ecran
	    int	    21h					; imprime no ecran
	    jmp	    ler_ciclo			; continua a ler o ficheiro

erro_ler:
        mov     ah,09h
        lea     dx,Erro_Ler_Msg
        int     21h

fecha_ficheiro:					; vamos fechar o ficheiro 
        mov     ah,3eh
        mov     bx,HandleFich
        int     21h
        jnc     sai

        mov     ah,09h			; o ficheiro pode não fechar correctamente
        lea     dx,Erro_Close
        Int     21h
sai:	  RET
Imp_Fich	endp
; :::::::::::::::::: Imprimir Ficheiro para STDOUT ::::::::::::::::::

; :::::::::::::::::: ROTINA PARA APAGAR ECRAN ::::::::::::::::::
; author: Professor
clear_screen	proc
		push bx
		xor	bx,bx
		mov	cx,25*80
		
apaga:	
		mov	byte ptr es:[bx],' '
		mov	byte ptr es:[bx+1],7
		inc	bx
		inc 	bx
		loop	apaga
		pop	bx
		ret
clear_screen	ENDP
; :::::::::::::::::: ROTINA PARA APAGAR ECRAN ::::::::::::::::::


;********************************************************************************
; LEITURA DE UMA TECLA DO TECLADO    (ALTERADO)
; LE UMA TECLA	E DEVOLVE VALOR EM AH E AL
; SE ah=0 É UMA TECLA NORMAL
; SE ah=1 É UMA TECLA EXTENDIDA
; AL DEVOLVE O CÓDIGO DA TECLA PREMIDA
; Se não foi premida tecla, devolve ah=0 e al = 0
;********************************************************************************
LE_TECLA_0	PROC
	;	call 	Trata_Horas
		MOV		AH,0BH
		INT 	21h
		cmp 	AL,0
		jne		com_tecla
		mov		AH, 0
		mov		AL, 0
		jmp		SAI_TECLA
		
com_tecla:		
		MOV		AH,08H
		INT		21H
		MOV		AH,0
		CMP		AL,0
		JNE		SAI_TECLA
		MOV		AH, 08H
		INT		21H
		MOV		AH,1
SAI_TECLA:	
		RET
LE_TECLA_0	ENDP


; :::::::::::::::::: Passa Tempo ::::::::::::::::::
; author: Professor
PASSA_TEMPO PROC	
 	
		MOV AH, 2CH             ; Buscar a hORAS
		INT 21H                 
		
 		XOR AX,AX
		MOV AL, DL              ; centesimos de segundo para ax		
		mov Centesimos, AX
	
		mov bl, factor		; define velocidade da snake (100; 50; 33; 25; 20; 10)
		div bl
		mov resto, AH
		mov AL, FACTOR
		mov AH, 0
		mov bl, 2
		div bl
		mov metade_FACTOR, AL
		mov AL, resto
		mov AH, 0
		mov BL, metade_FACTOR	; deve ficar sempre com metade do valor inicial
		mov AH, 0	
		cmp AX, BX
		jbe Menor
		mov AX, 1
		mov PASSA_T, AX	
		jmp fim_passa	
		
Menor:		mov AX,0
		mov PASSA_T, AX		

fim_passa:	 

 		RET 
PASSA_TEMPO   ENDP 
; :::::::::::::::::: Passa Tempo ::::::::::::::::::

; :::::::::::::::::: Controlador do Menu ::::::::::::::::::
menu_controller PROC
push	ax
push	bx
push	cx
push	dx
	xor		ax,	ax
	xor		dx,	dx

show_main_menu:
		; lea		dx, Menu
		; call	Imp_Fich
		lea		dx, MainMenuView
		mov		ah, 09h
		int 	21h

		call 	get_menu_option

		cmp		al, '0'
		je		tutorial

		cmp		al, '1'
		je		gameopts
		
		cmp 	al, '2'
		je 		stats
		
		cmp 	al, '3'
		je 		madeby
		
		cmp		al, '4'
		je		fim_menu

		call	wrong_input
		jmp		show_main_menu

tutorial:
		; lea		dx,	TutorialFile
		; call	Imp_Fich				; imprime o ficheiro corresponde ao tutorial
		lea		dx, HowToPlayView
		mov		ah, 09h
		int 	21h
		call	get_menu_option
		jmp		show_main_menu          ; volta ao menu principal

gameopts:
		
		; lea		dx,	newGame				; imprime o ficheiro corresponde ao menu de jogo
		; call	Imp_Fich
		lea		dx, newGameView
		mov		ah, 09h
		int 	21h
	gameopts_wrong_input:

		call 	get_menu_option			; Lê opção inserida pelo jogador

		cmp		al, '1'
		je 		classic_game

		cmp		al, '2'
		je		bonus_game 			; Bonus Game

		cmp 	al, '3'
		je		show_main_menu
 
		call 	wrong_input
		jmp		gameopts

classic_game:
	lea		dx, ChooseDifficultyView
	mov		ah, 09h
	int		21h

	call 	get_menu_option			; le opcao do jogador

	cmp 	al , '1'
	je 		slug

	cmp 	al, '2'
	je		hare

	cmp		al, '3'
	je		cheetah

	cmp		al,	'4'
	je		gameopts

	call	wrong_input
	jmp		classic_game

	slug: 
		mov factor, 100
		mov difficulty, 1
		jmp game_start

	hare:
		mov factor, 50
		mov difficulty, 2
		jmp game_start

	cheetah:
		mov factor, 25
		mov difficulty, 3
		jmp game_start

	game_start:
		call 	start_game
		jmp		show_main_menu

bonus_game:
	lea		dx, BonusChooseDifficultyView
	mov		ah, 09H
	int		21H

	call	get_menu_option

	cmp		al, '1'
	je		bonus_play

	cmp		al, '2'
	je		edit_board

	cmp		al, '3'
	je		gameopts

	call	wrong_input
	jmp		bonus_game

bonus_play:
	lea		dx, ChooseDifficultyView
	mov		ah, 09H
	int		21h

	call	get_menu_option

	cmp 	al , '1'
	je 		slug_0

	cmp 	al, '2'
	je		hare_0

	cmp		al, '3'
	je		cheetah_0

	cmp		al, '4'
	je		bonus_game

	call	wrong_input
	jmp		bonus_play

slug_0:
	mov		factor, 100
	jmp		bonus_game_start

hare_0:
	mov		factor, 50
	jmp		bonus_game_start

cheetah_0:
	mov		factor, 25
	jmp		bonus_game_start

edit_board:
		lea		dx, EditorMapMenu
		mov		ah, 09H
		int		21H
		
		call	get_menu_option

		cmp		al, '1'
		je		new_editor

		cmp		al, '2'
		je		load_editor

		cmp		al, '3'
		je		bonus_game

		call	wrong_input
		jmp		edit_board

new_editor:
; TODO - corrigir SetupNewEditor ou criar uma string nova para o new_editor
		;call	SetupNewEditor
		lea		dx, StandardMapEditor				; vai buscar o ponteiro da a string
		mov		ah, 09H
		int		21h
		call	changeBoard							; rotina para editar o mapa
		jmp		edit_board

load_editor:
		lea		dx, map_editor
		call	LoadEditorToMemory
		call	changeBoard
		jmp	edit_board

bonus_Game_start:
	call	start_bonus_game  
	jmp		show_main_menu

stats:
		lea		dx, StatsMenuView			; coloca o ponteiro para a string em dx
		mov		ah, 09h
		int 	21h							; chama a interrupcao para imprimir string em stdout
		call 	get_menu_option				; recebe input do teclado

		; Game History
		cmp		al, '1'
		je	 	game_history

		; Statistical Values
		cmp		al, '2'
		je		game_stats

		cmp		al, '3'
		je	 	show_main_menu

		call	wrong_input
		jmp		stats

game_history:
		lea		dx, GameHistoryView
		mov		ah, 09H
		int		21H
		call	get_menu_option
		jmp		stats

game_stats:
		lea		dx, StatsView
		mov		ah, 09H
		int		21H

		goto_xy 31, 16
		lea		dx, nr_games
		mov		ah, 09H
		int		21H
		goto_xy	31, 17
		lea		dx, best_play
		mov		ah, 09H
		int		21H
		goto_xy	32, 18
		lea		dx, worst_play
		mov		ah, 09H
		int		21H
		goto_xy	34, 19
		lea		dx, average_play
		mov		ah, 09H
		int		21H
		call	get_menu_option
		jmp		stats

madeby:
		lea		dx, CreditsView
		mov		ah, 09h
		int		21h
		mov		ah, 07h
		int 	21h
		jmp		show_main_menu

fim_menu:
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		ret
menu_controller endp

;recebe handle do ficheiro em dx
LoadEditorToMemory proc
		push	ax
		push	bx
		push	cx
		xor		si,si
		mov     ah,3dh				; vamos abrir ficheiro para leitura 
        mov     al,0				; tipo de ficheiro
        int     21h					; abre para leitura 
        jc      erro_abrir			; pode aconter erro a abrir o ficheiro 
        mov     HandleFich,ax		; ax devolve o Handle para o ficheiro 
        jmp     ler_ciclo			; depois de abero vamos ler o ficheiro 

erro_abrir:
        mov     ah,09h
        lea     dx,Erro_Open
        int     21h
        jmp     sai

ler_ciclo:
        mov     ah,3fh				; indica que vai ser lido um ficheiro 
        mov     bx,HandleFich		; bx deve conter o Handle do ficheiro previamente aberto 
        mov     cx,1				; numero de bytes a ler 
        lea     dx,car_fich			; vai ler para o local de memoria apontado por dx (car_fich)
        int     21h					; faz efectivamente a leitura
	    jc	    erro_ler			; se carry é porque aconteceu um erro
	    cmp	    ax,0				; EOF?	verifica se já estamos no fim do ficheiro 
	    je	    fecha_ficheiro		; se EOF fecha o ficheiro 
		mov		dl, car_fich
		mov		MapEditor[si], dl
		inc		si
        ; mov     ah,02h				; coloca o caracter no ecran
	    ; mov	    dl,car_fich			; este é o caracter a enviar para o ecran
	    ; int	    21h					; imprime no ecran

	    jmp	    ler_ciclo			; continua a ler o ficheiro

erro_ler:
        mov     ah,09h
        lea     dx,Erro_Ler_Msg
        int     21h

fecha_ficheiro:					; vamos fechar o ficheiro 
        mov     ah,3eh
        mov     bx,HandleFich
        int     21h
        jnc     sai

        mov     ah,09h			; o ficheiro pode não fechar correctamente
        lea     dx,Erro_Close
        Int     21h
sai:	
		pop	cx
		pop	bx
		pop	ax
		RET
LoadEditorToMemory endp


SetupNewEditor proc
	push	ax
	push	bx
	push	cx

	xor	si, si
	xor	cx, cx
	mov	si, 161		; comecar na primeira posicao do editor

ciclo_0:
	cmp	si, 1626				; ultima posicao do editor
	je	fim_setup
	cmp	cx, 61					; cada linha do editor tem 
	je	next_line
	mov	MapEditor[si], ' '
	inc	cx
	jmp	ciclo_0

next_line:
	add	si, 17 ; para saltar para a linha de baixo no editor
	xor	cx, cx
	jmp	ciclo_0

fim_setup:
	pop	cx
	pop	bx
	pop	ax
SetupNewEditor endp
; :::::::::::::::::: Controlador do Menu ::::::::::::::::::

LE_TECLA	PROC

		mov		ah,08h
		int		21h
		mov		ah,0
		cmp		al,0
		jne		SAI_TECLA
		mov		ah, 08h
		int		21h
		mov		ah,1
SAI_TECLA:	RET
LE_TECLA	endp

; Change Game Board

changeBoard proc
		push	ax
		push	bx
		xor		si, si
setup_view:
		lea		dx, MapEditor
		mov		ah, 09H
		int		21h
		mov 	bl, 11
		mov		bh, 34
		mov		posx, bh
		mov		posy, bl
		goto_xy	posx, posy
LER_SETA:
		xor		bx, bx
		call 	LE_TECLA
		cmp		ah, 1
		je		ESTEND
		CMP 	AL, 's'	; ESCAPE
		je		save
		cmp		al, 'h'
		je		help
		cmp		al, 32			; space
		jne 	LER_SETA

		mov		ah, 08H
		mov		bh, 0
		int		10h

		cmp		al, ' '
		je		createMuro

		mov		ah, 02H
		mov		dl, ' '
		int		21H
		push	bx				; guardar bx na pilha (nao perder o valor)
		mov		bl, posx		; guardo o x em bx
		push	ax				; guardar ax na pilha (nao perder o valor)
		mov		ax,	80			; guardar o nr. de celulas que cada linha tem em ax
		mul		posy			; multiplicar o nr. de celulas pela posicao em y (corresponde ao nr. de linhas)
		add		bx, ax			; adicionar a posicao de x ao resultado da multiplicacao = nr da celula atual do cursor
		mov		si, bx			; colocar esse valor em si por comodidade
		pop		ax				; retirar os valores da pilha
		pop 	bx				; retirar os valores da pilha
		mov	MapEditor[si], ' '	; colocar 'space' na string
		inc		posx
		goto_xy posx, posy
		mov		ah, 02H
		mov		dl, ' '
		int		21H
		inc		si				; incrementar o si para que a posicao correspondente no ecra seja equivalente na string
		mov	MapEditor[si], ' '	; colocar 'space' na string
		dec		si				; voltar ao valor original (porque o cursor só anda nas celulas do lado esquerdo)
		dec		posx
		goto_xy	posx, posy
		jmp 	LER_SETA

createMuro:
		mov		ah, 02H
		mov		dl, '#'
		int		21H
		push	bx
		push	ax
		mov		bl, posx
		mov		ax, 80
		mul		posy
		add		bx, ax
		pop		ax
		mov		si, bx
		pop		bx
		mov	MapEditor[si], '#'	; colocar '#' na string
		inc		posx
		goto_xy posx, posy
		mov		ah, 02H
		mov		dl, '#'
		int		21H
		inc		si
		mov	MapEditor[si], '#'	; colocar '#' na string
		dec		si
		dec		posx
		goto_xy	posx, posy
		jmp LER_SETA

save:
		call clear_screen
		lea	dx, map_editor
		call SaveBonusMap
		pop	bx
		pop	ax
		ret
		jmp		LER_SETA
		
ESTEND:		
		cmp 	al,48h
		jne		BAIXO
		cmp		posy, 2			; para nao saltar fora do mapa
		je		baixo	
		dec		POSy		;cima
		goto_xy	posx, posy
		jmp		LER_SETA

BAIXO:		
		cmp		al,50h
		jne		ESQUERDA
		cmp		posy, 21		; para nao saltar fora do mapa
		je		esquerda
		inc 	POSy		;Baixo
		goto_xy	posx, posy
		jmp		LER_SETA

ESQUERDA:
		cmp		al,4Bh
		jne		DIREITA
		cmp		posx, 4			; para nao saltar fora do mapa
		je		direita
		dec		POSx		;Esquerda
		dec		POSx		;Esquerda
		goto_xy	posx, posy
		jmp		LER_SETA

DIREITA:
		cmp		al,4Dh
		jne		help
		cmp		posx, 64		; para nao saltar fora do mapa
		je		help 
		inc		POSx		;Direita
		inc		POSx		;Direita
		goto_xy	posx, posy
		jmp	LER_SETA

help:
		cmp		al, 'h'
		jne		LER_SETA
		call	clear_screen
		lea		dx, MapEditorHelp
		mov		ah, 09H
		int		21h
		call	get_menu_option
		jmp		setup_view
	
changeBoard endp

; passar em dx a handle para o ficheiro
SaveBonusMap proc
push	ax
push	bx
push	cx
push	dx
		mov		ah, 3ch				; Abrir o ficheiro para escrita
		mov		cx, 00H				; Define o tipo de ficheiro 
		;lea		dx, fname			; DX aponta para o nome do ficheiro 
		int		21h				; Abre efectivamente o ficheiro (AX fica com o Handle do ficheiro)
		jnc		escreve				; Se não existir erro escreve no ficheiro
	
		mov		ah, 09h
		lea		dx, msgErrorCreate
		int		21h
	
		jmp		fim

escreve:
		mov		bx, ax				; Coloca em BX o Handle
		mov		ah, 40h				; indica que é para escrever
    	
		lea		dx, MapEditor		; DX aponta para a informação a escrever
		mov		cx, 1920				; CX fica com o numero de bytes a escrever
		int		21h				; Chama a rotina de escrita
		jnc		close				; Se não existir erro na escrita fecha o ficheiro
	
		mov		ah, 09h
		lea		dx, msgErrorWrite
		int		21h
close:
		mov		ah,3eh				; fecha o ficheiro
		int		21h
		jnc		fim_save
	
		mov		ah, 09h
		lea		dx, msgErrorClose
		int		21h

fim_save:
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		ret
SaveBonusMap endp
; :::::::::::::::::: Obter Opção ::::::::::::::::::
get_menu_option PROC
	goto_xy		21, 20			; Vai para posição do cursor
	mov			ah,	07h
	int			21h
	cmp			al, 1Bh			; ESC - Fast Ending
	je			close
	ret

close:
	call		clear_screen
	jmp			fim

get_menu_option endp
; :::::::::::::::::: Obter Opção ::::::::::::::::::

; :::::::::::::::::: Movimento da Cobra ::::::::::::::::::
move_snake PROC
CICLO:
	call		add_ratos
	call 		dir_vector
	; call		get_menu_option
	goto_xy		head_x,head_y		; Vai para nova posição
	mov 		ah, 08h				; Guarda o Caracter que está na posição do Cursor
	mov			bh,0				; numero da página
	int			10h
	
	cmp 		al, '#'				;  na posição do Cursor
	je			fim_jogo
	cmp 		al, 'V'
	je			maca_verde
	cmp			al, 'M'
	je 			maca_madura
	cmp			al, 'R'
	je			rato

	jmp cont_ciclo

maca_verde:
	xor 	ax,ax
	mov 	al, difficulty
	add 	pontos, ax				; adiciona 1*dificuldade pontos
	call	mostra_pontuacao 	; Mostra prontuação
	call 	add_apple
	inc 	maca
	dec		nr_macas
	call 	limpa_maca
	jmp 	cont_ciclo

maca_madura:
	xor 	ax,ax
	mov 	al, difficulty
	mov 	bl, 2
	mul 	bl					
	add 	pontos, ax				; adiciona 2*dificuldade pontos
	call	mostra_pontuacao 	; Mostra prontuação
	call 	add_apple
	inc	 	maca
	inc	 	maca
	dec		nr_macas
	call 	limpa_maca
	jmp 	cont_ciclo

rato:
	xor ax,ax

	; xor bx,bx
	; mov al, 160
	; mul rato_y
	; mov si,ax
	; mov al, 2
	; mul rato_x
	; mov bx,ax
	; mov dl,' '
	; mov dh, 60h
	; mov es:[si][bx], dx
	; mov es:[si][bx+2], dx

	mov al, difficulty
	mov bl, 5
	mul bl
	cmp pontos, ax
	jae neg_points				; se tiver menos pontos que os que deve retirar, retira todos os pontos que tem
	mov ax, pontos

neg_points:
	sub pontos, ax
	call	mostra_pontuacao 	; Mostra prontuação
	call come_rato

cont_ciclo:
		cmp maca, 0					
		ja dec_maca

	;; Limpar o rasto da cabeça da cobra

		goto_xy		tail_x,tail_y		; Vai para a posição anterior do cursor
		mov			ah, 02h
		mov			dl, ' ' 		; Coloca ESPAÇO
		int			21H
		mov 		ah, tail_x
		mov 		posxa, ah
		inc			POSxa
		goto_xy		POSxa,tail_y	
		mov			ah, 02h
		mov			dl, ' '			;  Coloca ESPAÇO
		int			21H	
		call 		move_tail



IMPRIME:
	;; Atualizar a cabeça da cobra
		goto_xy		head_x,head_y		; Vai para posição do cursor
		;call		verifica_rato
		mov 		ah, 08h				; Guarda o Caracter que está na posição do Cursor
		mov			bh,0				; numero da página
		int			10h

		cmp 		al, '('				;  se houver cobra na posição atual, game over
		je			fim_jogo

		mov			ah, 02h
		mov			dl, '('				; Coloca AVATAR1
		int			21H
		
		mov 		ah, head_x
		mov 		posx, ah
		inc			POSx
		goto_xy		posx,head_y		
		mov			ah, 02h
		mov			dl, ')'			; Coloca AVATAR2
		int			21H	

		goto_xy		head_x, head_y		; Vai para posição do cursor
		cmp			nr_macas, 0
		je			spawn_maca

		jmp			LER_SETA

spawn_maca:
		call 	add_apple
		inc		nr_macas
		
LER_SETA:	
		call 		LE_TECLA_0
		cmp			ah, 1
		je			ESTEND
		CMP 		AL, 27			; ESCAPE
		jne			TESTE_END
		jmp			fim
		; call		are_you_sure_about_that
TESTE_END:		
		CALL		PASSA_TEMPO
		mov			AX, PASSA_T_ant
		CMP			AX, PASSA_T
		je			LER_SETA
		mov			AX, PASSA_T
		mov			PASSA_T_ant, AX

verifica_0:	
		mov			al, direccao
		cmp 		al, 0
		jne			verifica_1
		add			head_x, 2		;Direita
		jmp			CICLO
		
verifica_1:	
		mov 		al, direccao
		cmp			al, 1
		jne			verifica_2
		dec			head_y		;cima
		jmp			CICLO
		
verifica_2:	
		mov 		al, direccao
		cmp			al, 2
		jne			verifica_3
		sub 		head_x, 2		;Esquerda
		jmp			CICLO
		
verifica_3:	
		mov 		al, direccao
		cmp			al, 3	
		jne			CICLO
		inc			head_y		;BAIXO	
		jmp			CICLO
		
ESTEND:		
		cmp 		al,48h
		jne			BAIXO
		cmp			snake_dir[0], 3
		je			LER_SETA
		mov			direccao, 1
		jmp			LER_SETA

BAIXO:
		cmp			al,50h
		jne			ESQUERDA
		cmp			snake_dir[0], 1
		je			LER_SETA
		mov			direccao, 3
		jmp			LER_SETA

ESQUERDA:
		cmp			al,4Bh
		jne			DIREITA
		cmp			snake_dir[0], 0
		je			LER_SETA
		mov			direccao, 2
		jmp			LER_SETA

DIREITA:
		cmp			al,4Dh
		jne			LER_SETA 
		cmp			snake_dir[0], 2
		je			LER_SETA
		mov			direccao, 0
		jmp			LER_SETA

fim_jogo:		
		call		clear_screen
		call		game_over;
		RET

dec_maca:
		dec 		maca
		inc 		tam
		jmp 		imprime

move_snake ENDP

dir_vector PROC
	xor si,si
	xor ax,ax
	mov al, tam
	mov cx, ax
	inc cx					; como tam = tamanho da cobra - 1,  inc no cx
	mov al, direccao
ccl:
	xchg al, snake_dir[si]		; al = direçao que a 'peça' seguinte mais perto da cauda vai ter,  snake_dir(si) = dir que a posição anterior tinha
	inc si			; basicamente AL=0   snake dir=3,1,3,2,1   ->   snake_dir=0,3,1,3,2
	loop ccl
	ret
dir_vector endp

move_tail proc
	xor ax,ax
	mov al,tam
	mov si,ax
	mov al, snake_dir[si]		;al passa a ter direção que a cauda se deve mexer
	cmp al, 0 ;direita
	je tail_dir
	cmp al, 1 ;cima
	je tail_cima
	cmp al, 2 ;esquerda
	je tail_esq
	cmp al, 3 ;baixo
	je tail_baix
	ret
	tail_dir:
	add tail_x,2			;mexe para direita
	jmp fim_tail
	tail_cima:
	dec tail_y				;mexe para cima
	jmp fim_tail
	tail_esq:				
	sub tail_x, 2			;mexe para esquerda
	jmp fim_tail
	tail_baix:				
	inc tail_y				;mexe para baixo
	fim_tail:
	ret
move_tail endp

limpa_maca proc

	xor ax,ax
	xor bx,bx
	mov al, 160
	mul head_y
	mov si,ax
	mov al, 2
	mul head_x
	mov bx,ax
	mov dx, 3720h
	mov es:[si][bx], dx
	mov es:[si][bx+2], dx
	dec	nr_macas

	ret

limpa_maca endp

come_rato proc

	xor cx,cx
	xor bx,bx
	mov cx, 5
	cmp tam, 5
	jae ciclo_rato
	mov cl, tam
ciclo_rato:
	mov ah, tail_x
	mov posx, ah
	goto_xy tail_x, tail_y
	mov dl,' '
	mov ah,02h
	int 21h
	inc posx
	goto_xy posx, tail_y
	mov dl, ' '
	int 21h
	mov bl, tam
	cmp snake_dir[bx], 0
	jne dir_cim
	add tail_x, 2
	jmp fim_rato
dir_cim:
	cmp snake_dir[bx], 1
	jne dir_esq
	dec tail_y
	jmp fim_rato
dir_esq:
	cmp snake_dir[bx], 2
	jne dir_baix
	sub tail_x, 2
	jmp fim_rato
dir_baix:
	inc tail_y
fim_rato:
	dec tam
loop ciclo_rato
	ret
come_rato endp
; :::::::::::::::::: Movimento da Cobra ::::::::::::::::::

; :::::::::::::::::: Mostra Pontuação ::::::::::::::::::
mostra_pontuacao proc    ; 8 bits max pontos
	push	ax
	push	bx
	push	cx
	push	dx
	xor		si, si
	xor		dx, dx
	xor		ax, ax
	xor		bx, bx
	mov		bx, 10
	mov		AX, pontos

break_chars:
	xor		dx, dx
	div		bx					; ah fica com o caracter a converter para ascii
	add		dl, 30h				; para converter para ascii
	mov		str_aux[si], dl
	cmp		ax, 0
	je		display
	inc		si
	jmp		break_chars
	
display:
	goto_xy	posxpont, posypont
display_pont:
	xor		dl, dl
	mov		ah, 02h
	mov		dl, str_aux[si]
	int		21h
	cmp		si, 0
	je		fim_mostra
	dec		si
	jmp		display_pont

fim_mostra:
	goto_xy	posx, posy  		
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	ret
mostra_pontuacao endp
; :::::::::::::::::: Mostra Pontuação ::::::::::::::::::

; :::::::::::::::::: MACRO Imprime String ::::::::::::::::::
; macro para imprimir uma string no stdout
; params - recebe a string que vai imprimir
mostra MACRO str
	mov		ah, 09h
	lea		dx,	str
	int		21h	
endm
; :::::::::::::::::: MACRO Imprime String ::::::::::::::::::

; :::::::::::::::::: Imprime avisos de wrong input ::::::::::::::::::
wrong_input proc
		goto_xy 14,22			; Vai para a posição de aviso
        mov     ah,09h
        lea     dx,Erro_Input	; coloca a mensagem de erro no registo necessário
        int     21h				; chama a int para imprimir no stdout
		mov		ah, 07h
		goto_xy	posx, posy		; volta para a posição antiga do cursor
		call 	get_menu_option
		call	clear_screen
		ret
wrong_input endp
; :::::::::::::::::: Imprime avisos de wrong input ::::::::::::::::::

; :::::::::::::::::: Calcula Aleatorio ::::::::::::::::::
; author: Professor
; CalcAleat - calcula um numero aleatorio de 16 bits
; Parametros passados pela pilha
; entrada:
; n�o tem parametros de entrada
; saida:
; param1 - 16 bits - numero aleatorio calculado
; notas adicionais:
; deve estar definida uma variavel => ultimo_num_aleat dw 0
; assume-se que DS esta a apontar para o segmento onde esta armazenada ultimo_num_aleat
CalcAleat proc near

	push ax
	push dx
	push cx

	mov ah, 2Ch
	int 21H
	xor ax,ax
	mov al, dh
	xor dh, dh
	mul dx
	xchg dx,ax
	xchg dl, dh
	mov ax, 65521
	mul dx
	xchg al,ah
	mov ultimo_num_aleat, ax

	pop cx
	pop dx
	pop ax
	ret

	; sub		sp,2		; 
	; push	bp
	; mov		bp,sp
	; push	ax
	; push	cx
	; push	dx	
	; mov		ax,[bp+4]
	; mov		[bp+2],ax

	; mov		ah,00h
	; int		1ah

	; add		dx,ultimo_num_aleat	; vai buscar o aleat�rio anterior
	; add		cx,dx
	; mov		ax,65521
	; push	dx
	; mul		cx			
	; pop		dx			 
	; xchg	dl,dh
	; add		dx,32749
	; add		dx,ax

	; mov		ultimo_num_aleat,dx	; guarda o novo numero aleat�rio

	; mov		[BP+4],dx		; o aleat�rio � passado por pilha

	; pop		dx
	; pop		cx
	; pop		ax
	; pop		bp
	; ret

CalcAleat endp
; :::::::::::::::::: Calcula Aleatorio ::::::::::::::::::

; :::::::::::::::::: Gera Coordenada de X válida ::::::::::::::::::
; param : recebe em dl um aleatorio de 8 bits
; NOTA: devolve sempre a mini celula da esquerda
; return: Ah - x coord
valid_Xcoord proc
	xor		dx, dx
	mov		dx,	ultimo_num_aleat
	xor 	ax,	ax
	xor		cx, cx

	mov		al, dh
	mov		cl, 30
	mul		cl
	xor		cx, cx
	mov		cl, 255
	div		cl
	mov cl, 2
	mul cl

	add		al, 4	 			; garantir que o nr e superior a 4

	mov		posx, al
	ret
valid_Xcoord endp
; :::::::::::::::::: Gera Coordenada de X válida ::::::::::::::::::

; :::::::::::::::::: Gera Coordenada de Y válida ::::::::::::::::::
; param : recebe em dl um aleatorio de 8 bits
; NOTA: devolve sempre a mini celula da esquerda
; return: Al - y coord
valid_Ycoord proc
	xor		dx, dx
	mov		dx,	ultimo_num_aleat
	xor		ax,	ax
	xor 	cx, cx
	; cmp		dl, 20			
	; jge		invalid_0
	; cmp		dl, 2
	; jb		invalid_2
	; ret
; invalid_0:
	mov		al, dl
	mov		cl, 20
	mul		cl
	xor		cx, cx
	mov		cl, 255
	div		cl
	add		al, 2
	; jmp		valid_fim
; invalid_2:
	; add		al, 4
; valid_fim:
	mov		posy, al	
	ret
valid_Ycoord endp
; :::::::::::::::::: Gera Coordenada de Y válida ::::::::::::::::::

; :::::::::::::::::: Adiciona Macas ::::::::::::::::::

add_apple proc
	; xor		ax, ax				
	; mov		al, posx			; guardar a posicao anterior
	; mov		posxa, al
	; mov		ah, posy
	; mov		posya, ah
	mov		bl, 1
	mov		nr_macas, bl
generate_position:
	;call 	CalcAleat
	xor		ax, ax
	xor		dx, dx
	xor		bx, bx
	call 	CalcAleat
	call	valid_Xcoord		; obter uma posicao valida no gameboard
	mov		posx, al
	call 	CalcAleat
	call	valid_Ycoord
	mov		posy, al
	goto_xy	posx, posy			; colocar o cursor nessa posicao
	
	mov		ah, 08H
	mov		bh, 0				; le o caracter que esta na posicao atual do cursor
	int		10h

	cmp		al, '('
	je		generate_position  ; se a maca for gerada estiver em cima da cobra

	xor		cx, cx
	xor		ax, ax
	xor		dx, dx
	mov		dx, ultimo_num_aleat
	mov		al, dl
	mov		cl, 2
	div		cl
	cmp		ah, 0
	je		maca_verde_0

	xor ax,ax
	xor bx,bx
	mov al, 160
	mul posy
	mov si,ax
	mov al, 2
	mul posx
	mov bx,ax
	mov dl,'M'
	mov dh, 45h
	mov es:[si][bx], dx
	mov es:[si][bx+2], dx
	jmp fim_add


maca_verde_0:
	xor ax,ax
	xor bx,bx
	mov al, 160
	mul posy
	mov si,ax
	mov al, 2
	mul posx
	mov bx,ax
	mov dl,'V'
	mov dh, 23h
	mov es:[si][bx], dx
	mov es:[si][bx+2], dx

fim_add:
	ret
add_apple endp
; :::::::::::::::::: Adiciona Macas ::::::::::::::::::

; :::::::::::::::::: Adiciona Ratos ::::::::::::::::::
add_ratos proc
	
	xor	ax, ax
	xor	bx, bx
	xor	cx, cx
	xor	dx, dx

	cmp		nr_ratos, 0
	je		add_rato
	jmp		verifica_rato

add_rato:
	call	CalcAleat
	call	valid_Xcoord
	mov		rato_x, al
	call	CalcAleat
	call	valid_Ycoord
	mov		rato_y, al
	; xor		ax, ax
	; mov		ah, posx
	; mov		al, posy
	; mov		rato_x, ah
	; mov		rato_y, al
	goto_xy rato_x, rato_y
	
	mov		ah, 02H
	mov		dl, 'R'
	int		21H
	inc		rato_x
	goto_xy rato_x, rato_y
	;dec		rato_x

	mov		ah, 02H
	mov		dl, 'R'
	int		21H
	;goto_xy rato_x, rato_y

	mov		bl, nr_ratos
	inc		bl
	mov		nr_ratos, bl


	mov		ah, 2ch			; tempo do sistema
	int		21h
	mov		rato_nasce, dh

verifica_rato:
	mov	ah, 2ch
	int	21h
	cmp	dh, rato_nasce
	jb	add60
	jmp	TempoDeVida
add60:
	add dh, 60
TempoDeVida:
	sub	dh, rato_nasce
	cmp	dh, 4
	jge	mata_rato
	jmp fim_add_rato
mata_rato:
	; goto_xy rato_x, rato_y
	; mov	ah, 02H
	; mov	dl, ' '
	; int	21H
	; inc rato_x
	; goto_xy rato_x, rato_y
	; dec rato_x
	; mov	ah, 02H
	; mov	dl, ' '
	; int	21h
	
	; mov	bl, 0
	; mov	rato_nasce, bl

fim_add_rato:
	ret
add_ratos endp
; :::::::::::::::::: Adiciona Ratos ::::::::::::::::::
verifica_rato proc
	push ax
	push bx
	push dx
	xor	ax, ax
	mov	ah, 2ch
	int	21H

	mov al, dh
	mov bl, 4
	mul	bl
	xor	bx, bx
	mov	bl, 60
	div	bl
	xor	bx, bx
	mov bl, tp_vida
	sub	al, bl
	cmp	al, 0
	jbe	mata_rato
	jmp	fim_1

mata_rato:
	goto_xy rato_x, rato_y
	mov	ah, 02H
	mov	dl, ' '
	int	21H
	mov	bl, rato_x
	mov	posx, bl
	inc	posx
	goto_xy posx, rato_y
	mov	ah, 02H
	mov	dl, ' '
	int 21H
	goto_xy posx, posy

fim_1:
	pop dx
	pop	bx
	pop	ax
	ret
verifica_rato endp
; :::::::::::::::::: Start Game ::::::::::::::::::
start_game proc
	lea		dx, GameBoardView
	mov		ah, 09h
	int		21H

	cmp		difficulty, 1
	je		slug_level
	cmp		difficulty, 2
	je		hare_level
	goto_xy	posxlevel, posylevel
	lea		dx, cheetah_label
	mov		ah,	09h
	int		21h
	jmp		@@asd

slug_level:
	goto_xy	posxlevel, posylevel
	lea		dx, slug_label
	mov		ah,	09h
	int		21h
	jmp		@@asd
hare_level:
	goto_xy	posxlevel, posylevel
	lea		dx, hare_label
	mov		ah,	09h
	int		21h

@@asd:
	xor		ax,	ax
	xor		bx, bx
	call 	CalcAleat
	call	valid_Xcoord
	mov 	head_x, al
	mov 	tail_x, al
	call	CalcAleat
	call	valid_Ycoord
	cmp al, 12
	ja abv12
	mov 	tail_y, al
	inc 	al
	mov 	head_y, al
	mov 	direccao, 3
continue_setup:	
	mov  	tam, 0
	xor		ax, ax
	; mov		al, tp_vida
	call	mostra_pontuacao
	call 	move_snake
	cmp		al, 1Bh		; considerando que sempre o jogo acaba o jogador perdeu
	call	are_you_sure_about_that
	call	game_over		; podemos validar o ESC para perguntar se quer mesmo sair
	ret
abv12:
	mov 	tail_y, al
	dec 	al
	mov 	head_y, al
	mov 	direccao, 1
	jmp continue_setup
start_game endp

start_bonus_game proc
	lea	dx, map_editor
	call	Imp_Fich

	cmp		difficulty, 1
	je		slug_level

	cmp		difficulty, 2
	je		hare_level
	goto_xy	posxlevel, posylevel

	lea		dx, cheetah_label
	mov		ah,	09h
	int		21h
	jmp		@@asd

slug_level:
	goto_xy	posxlevel, posylevel
	lea		dx, slug_label
	mov		ah,	09h
	int		21h
	jmp		@@asd
hare_level:
	goto_xy	posxlevel, posylevel
	lea		dx, hare_label
	mov		ah,	09h
	int		21h

@@asd:
	xor		ax,	ax
	xor		bx, bx
	; TODO: validar se a cabeça da cobra não nasce em cima de um muro
	call 	CalcAleat
	call	valid_Xcoord
	mov 	head_x, al
	mov 	tail_x, al
	call	CalcAleat
	call	valid_Ycoord
	cmp al, 12
	ja abv12
	mov 	tail_y, al
	inc 	al
	mov 	head_y, al
	mov 	direccao, 3
continue_setup:	
	mov  	tam, 0
	xor		ax, ax
	call 	move_snake		; TODO: mudar para o move do bonus
	cmp		al, 1Bh		; considerando que sempre o jogo acaba o jogador perdeu
	call	are_you_sure_about_that
	call	game_over		; podemos validar o ESC para perguntar se quer mesmo sair
	ret
abv12:
	mov 	tail_y, al
	dec 	al
	mov 	head_y, al
	mov 	direccao, 1
	jmp continue_setup
start_bonus_game endp
; :::::::::::::::::: Start Game ::::::::::::::::::

; :::::::::::::::::: are_you_sure_about_that? ::::::::::::::::::
are_you_sure_about_that proc
ciclo:
	lea		dx, YouSureAboutThatView
	mov		ah, 09H
	int		21h

	call	get_menu_option
	cmp		al, '0'
	JE		fim
	cmp	 	al, '1'
	je		game
	call	wrong_input
	jmp   	ciclo

game:
	call		start_game
	ret
are_you_sure_about_that endp
; :::::::::::::::::: are_you_sure_about_that? ::::::::::::::::::

; :::::::::::::::::: Game Over ::::::::::::::::::
game_over proc
	; TODO: rest em tudo o que é dados de jogo (para o caso do jogador querer voltar a jogar)
	; acho que já está feito verificar
wrong_0:
	call	clear_screen
	mov		tam,  1 ;; ANDRE: isto nao devia estar a 0 ?
	lea		dx, GameOverView
	mov		ah, 09h
	int 	21h
	call	get_menu_option
	cmp		al, '1'					; jogador nao quer voltar a jogar
	je		fim
	cmp		al, '0'					; jogador quer voltar a jogar
	je		restart_game
	
	call	wrong_input
	jmp		wrong_0
restart_game:
	xor		ax, ax
	mov		nr_ratos, al
	mov		nr_macas, al
	mov		pontos, ax
	call	menu_controller
game_over endp
; :::::::::::::::::: Game Over ::::::::::::::::::

INICIO:
	mov     	ax, DADOS
	mov     	ds, ax
	MOV			AX,0B800H 		
	MOV			ES,AX			
	CALL 		clear_screen
	call		menu_controller
fim:
	call clear_screen	
	mov     ah,4ch
	int     21h


CODIGO	ENDS
END	INICIO