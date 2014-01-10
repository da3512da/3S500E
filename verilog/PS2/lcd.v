module lcd (clk,rst_n,shift,capslock,speed,keyvalue,key_on,en,rs,rw,data,clk48hz,dis_key,shift_o,keyvalue_o,LCD_N,LCD_P);
	input			clk;
	input			rst_n;
	input			shift;
	input			capslock;
	input	[7:0]	keyvalue;
	input			key_on;
	input			speed;
	output		en;
	output		rs;
	output		rw,LCD_N,LCD_P;
	output		[7:0]	data;
	output      clk48hz;
	output		dis_key;
	output		shift_o;
	output	[7:0] keyvalue_o;
	reg		en;
	reg			rs;
	reg			[7:0]	data;
	
    reg     [3:0]   CS;                     //  ״̬�Ĵ���
    reg     [4:0]   address;                //  ��ʾ���ݵĵ�ַ    
    reg     [7:0]   dataram;                //  ��ʾ����Ĵ���
	reg				dis_key;
	reg				speed_r;
	reg	 [7:0]		lcdcode;
	reg	[4:0]		keynum;
	reg				clk3hz;
	reg				clk48hz;
	reg				clk4800hz;
	reg	[12:0]	clk_cnt1;
	reg	[17:0]	clk_cnt2;
	reg	[22:0]	clk_cnt3;	
	reg	[7:0]		keycode_1;
	reg	[7:0]		keycode_2;
	reg	[7:0]		keycode_3;
	reg	[7:0]		keycode_4;
	reg	[7:0]		keycode_5;
	reg	[7:0]		keycode_6;
	reg	[7:0]		keycode_7;
	reg	[7:0]		keycode_8;
	reg	[7:0]		keycode_9;
	reg	[7:0]		keycode_10;
	reg	[7:0]		keycode_11;
	reg	[7:0]		keycode_12;
	reg	[7:0]		keycode_13;
	reg	[7:0]		keycode_14;
	reg	[7:0]		keycode_15;
	reg	[7:0]		keycode_16;
	reg	[7:0]		keycode_17;
	reg	[7:0]		keycode_18;
	reg	[7:0]		keycode_19;
	reg	[7:0]		keycode_20;
	reg	[7:0]		keycode_21;
	reg	[7:0]		keycode_22;
	reg	[7:0]		keycode_23;
	reg	[7:0]		keycode_24;
	reg	[7:0]		keycode_25;
	reg	[7:0]		keycode_26;
	
	
    parameter    CLEAR              		= 4'b0000;          //  ����״̬
    parameter    INPUTSET           		= 4'b0011;          //	����Զ�����״̬
    parameter    DISPLAYSWITCH  	= 4'b0010;          //	����ʾ��,�����˸״̬
    parameter    FUNCTIONSET        = 4'b0110;          //	8λ2��5x7����
    parameter    DDRAM1             		= 4'b0100;          //	��һ���׵�ַ;
    parameter    DDRAM2               	= 4'b1100;          //	�ڶ����׵�ַ
    parameter    DATAWRITE1         	= 4'b1000;          //	д��һ������;
    parameter    DATAWRITE2         	= 4'b1001;          //	д�ڶ�������;
    parameter    SPACE              		= 8'b00100000;      //  LCD�ո�Ĵ���
	parameter	  DELETE                    = 8'h66;
     assign LCD_N=0;
  assign LCD_P=1;
	wire	capital = (capslock ^ shift);
	always @ (*)
	begin
	case(keyvalue)
	8'h00:
			begin
			lcdcode =SPACE;
			dis_key = 1'b0;
			end
	8'h1c: 
			 begin
			 dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h41;
			 else
			 lcdcode =8'h61;
			 end
	8'h32: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h42;
			 else
			 lcdcode =8'h62;
			 end
	8'h21: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h43;
			 else
			 lcdcode =8'h63;
			 end
	8'h23: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h44;
			 else
			 lcdcode =8'h64;
			 end
	8'h24: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h45;
			 else
			 lcdcode =8'h65;
			 end
	8'h2b:
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h46;
			 else
			 lcdcode =8'h67;
			 end
	8'h34: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h47;
			 else
			 lcdcode =8'h67;
			 end
	8'h33: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h48;
			 else
			 lcdcode =8'h68;
			 end
	8'h43: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h49;
			 else
			 lcdcode =8'h69;
			 end
	8'h3b: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h4a;
			 else
			 lcdcode =8'h6a;
			 end
	8'h42: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h4b;
			 else
			 lcdcode =8'h6b;
			 end
	8'h4b: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h4c;
			 else
			 lcdcode =8'h6c;
			 end
	8'h3a: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h4d;
			 else
			 lcdcode =8'h6d;
			 end
	8'h31: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h4e;
			 else
			 lcdcode =8'h6e;
			 end
	8'h44:
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h4f;
			 else
			 lcdcode =8'h6f;
			 end
	8'h4d: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h50;
			 else
			 lcdcode =8'h70;
			 end
	8'h15: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h51;
			 else
			 lcdcode =8'h71;
			 end
	8'h2d: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h52;
			 else
			 lcdcode =8'h72;
			 end
	8'h1b: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h53;
			 else
			 lcdcode =8'h73;
			 end
	8'h2c: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h54;
			 else
			 lcdcode =8'h74;
			 end
	8'h3c: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h55;
			 else
			 lcdcode =8'h75;
			 end
	8'h2a: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h56;
			 else
			 lcdcode =8'h76;
			 end
	8'h1d: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h57;
			 else
			 lcdcode =8'h77;
			 end
	8'h22: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h58;
			 else
			 lcdcode =8'h78;
			 end
	8'h35: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h59;
			 else
			 lcdcode =8'h79;
			 end
	8'h1a: 
			begin
			dis_key = 1'b1;
			 if(capital)
			 lcdcode = 8'h5a;
			 else
			 lcdcode =8'h7a;
			 end
	8'h45: 
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h29;
			else
			lcdcode = 8'h30;
			end
	8'h16: 
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h21;
			else
			lcdcode = 8'h31;
			end
	8'h1e: 
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h40;
			else
			lcdcode = 8'h32;
			end
	8'h26: 
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h23;
			else
			lcdcode = 8'h33;
			end
	8'h25: 
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h24;
			else
			lcdcode = 8'h34;
			end
	8'h2e: 
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h25;
			else
			lcdcode = 8'h35;
			end
	8'h36: 
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h5e;
			else
			lcdcode = 8'h36;
			end
	8'h3d: 
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h26;
			else
			lcdcode = 8'h37;
			end
	8'h3e:
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h2a;
			else
			lcdcode = 8'h38;
			end
	8'h46: 
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h28;
			else
			lcdcode = 8'h39;
			end
	8'h4e:
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h2d;
			else
			lcdcode = 8'hb0;
			end
	8'h55:
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h2b;
			else
			lcdcode = 8'h3d;
			end
	8'h4a:
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h3f;
			else
			lcdcode = 8'h2f;
			end
	8'h41:
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h3d;
			else
			lcdcode = 8'h2c;
			end
	8'h49:
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h3e;
			else
			lcdcode = 8'h2e;
			end
	8'h4c:
			begin
			dis_key = 1'b1;
			if(shift)
			lcdcode = 8'h3a;
			else
			lcdcode = 8'h3b;
			end
	default:
				begin
				lcdcode =SPACE;
				dis_key = 1'b0;
				end
	endcase
	end
		
		always @(posedge clk or negedge rst_n)
		begin
		if(~rst_n)
			begin
			clk4800hz <= 1'b0;
			clk_cnt1 <= 13'd0; 
			end
		else if(clk_cnt1 == 13'd5000)
			begin
			clk_cnt1 <= 13'd0;
			clk4800hz <= ~clk4800hz;
			end
		else
			clk_cnt1 <= clk_cnt1 + 13'd1;
		end
		
		always @(posedge clk or negedge rst_n)
		begin
		if(~rst_n)
			begin
			clk48hz <= 1'b0;
			clk_cnt2 <= 18'd0; 
			end
		else if(clk_cnt2== 18'd500000)
			begin
			clk_cnt2 <= 18'd0;
			clk48hz <= ~clk48hz;
			end
		else
			clk_cnt2 <= clk_cnt2 + 18'd1;
		end
	
	always @(posedge clk or negedge rst_n)
		begin
		if(~rst_n)
			begin
			clk3hz <= 1'b0;
			clk_cnt3 <= 23'd0; 
			end
		else if(clk_cnt3 == 23'd8000000)
			begin
			clk_cnt3 <= 23'd0;
			clk3hz <= ~clk3hz;
			end
		else
			clk_cnt3 <= clk_cnt3 + 23'd1;
		end
		
		always@( posedge clk or negedge rst_n)
		begin
		if(~rst_n)
			speed_r <= 1'b1;
		else
			speed_r <= speed;
		end
		
		wire speed_pulse =(~speed_r && speed);
		
	  	always@( posedge clk or negedge rst_n)
    	begin
        if(!rst_n)
            keynum <= 5'd0;
        else                                   
            begin
                if(keynum < 5'd26 && dis_key == 1'b1&&key_on &&speed_pulse)        //  �������ּ�ָ����һ��λ��
                    keynum <= keynum + 1'b1;
                else if(keynum > 5'b0 && keyvalue == DELETE &&key_on&&speed_pulse)     //  ����ɾ����ָ����һ��λ��
                    keynum <= keynum - 1'b1;
            end
    end
    
    reg	flag;
    always @ (posedge clk or negedge rst_n)
        if(!rst_n)
            flag <= 1'b1;
        else if(dis_key)                                      //  ���ּ�����
            flag <= 1'b1;  
        else if(keyvalue == DELETE)                                //  ɾ��������
            flag <= 1'b0;
       
    //*********************************************************************************
    //  ģ�����ƣ�  ����ģ��
    //  ����������  ������digit�ŵ����ֻ�����digit_reg�У�ʹ�����������ݱ仯�ӳ�keynum
    //              �仯��Ҫ��ʱ�䣬д����ʱҪ�õ��������
    //*********************************************************************************
   /* always @ (posedge clk3hz or negedge rst_n)
        if(!rst_n)
            key_reg <= 8'b0;
        else 
            key_reg <= lcdcode;*/
   
    //*********************************************************************************
    //  ģ�����ƣ�  д����ģ��
    //  ����������  ʵ��д��������ɾ������Ĺ���
    //*********************************************************************************
    always @ (posedge clk48hz)
        case(keynum)                            //  ÿдһ������keynum��1��ɾ��һ���������1
        5'd0:  
            begin
                keycode_1 <= SPACE;             //  ��ʼ״̬������LCD����ʾ���ǿո�
                keycode_2 <= SPACE;
                keycode_3 <= SPACE;
                keycode_4 <= SPACE;
                keycode_5 <= SPACE;
                keycode_6 <= SPACE;
                keycode_7 <= SPACE;
                keycode_8 <= SPACE;
                keycode_9 <= SPACE;
                keycode_10 <= SPACE;
                keycode_11 <= SPACE;
                keycode_12 <= SPACE;
                keycode_13 <= SPACE;
                keycode_14 <= SPACE;
                keycode_15 <= SPACE;
                keycode_16 <= SPACE;
                keycode_17 <= SPACE;
                keycode_18 <= SPACE;
                keycode_19 <= SPACE;
                keycode_20 <= SPACE;
                keycode_21 <= SPACE;
                keycode_22 <= SPACE;
                keycode_23 <= SPACE;
                keycode_24 <= SPACE;
                keycode_25 <= SPACE;
                keycode_26 <= SPACE;
            end
        5'd1:                                 
            begin                              
                if(flag)                        
                    keycode_1 <= lcdcode;     
				else
					keycode_1 <= keycode_1;  
                    keycode_2 <= SPACE;             
            end
        5'd2:                                          		
            begin                               
                if(flag)                      
                    keycode_2 <= lcdcode;     
                else                                		
                    keycode_2 <= keycode_2;    
                	keycode_3 <= SPACE;            
            end                                
        5'd3:                                 
            begin
                if(flag)
                    keycode_3 <= lcdcode;
                else 
                    keycode_3 <= keycode_3;
                	keycode_4 <= SPACE;
            end 
        5'd4: 
            begin
                if(flag)
                    keycode_4 <= lcdcode;
                else 
                    keycode_4 <= keycode_4;
                	keycode_5 <= SPACE;            
            end 
        5'd5: 
            begin           
                if(flag)
                    keycode_5 <= lcdcode;
                else 
                    keycode_5 <= keycode_5;
                	keycode_6 <= SPACE;
            end 
        5'd6: 
            begin           
                if(flag)
                    keycode_6 <= lcdcode;
                else 
                    keycode_6 <= keycode_6;
                	keycode_7 <= SPACE;
            end
         5'd7: 
            begin           
                if(flag)
                    keycode_7 <= lcdcode;
                else 
                    keycode_7 <= keycode_7;
                	keycode_8 <= SPACE;
            end
         5'd8: 
            begin           
                if(flag)
                    keycode_8 <= lcdcode;
                else 
                    keycode_8 <= keycode_8;
                	keycode_9 <= SPACE;
            end
         5'd9: 
            begin           
                if(flag)
                    keycode_9 <= lcdcode;
                else 
                    keycode_9 <= keycode_9;
                	keycode_10 <= SPACE;
            end
         5'd10: 
            begin           
                if(flag)
                    keycode_10 <= lcdcode;
                else 
                    keycode_10 <= keycode_10;
                	keycode_11 <= SPACE;
            end
         5'd11: 
            begin           
                if(flag)
                    keycode_11 <= lcdcode;
                else 
                    keycode_11 <= keycode_11;
                	keycode_12 <= SPACE;
            end
         5'd12: 
            begin           
                if(flag)
                    keycode_12 <= lcdcode;
                else 
                    keycode_12 <= keycode_12;
                	keycode_13 <= SPACE;
            end
         5'd13: 
            begin           
                if(flag)
                    keycode_13 <= lcdcode;
                else 
                    keycode_13 <= keycode_13;
                	keycode_14 <= SPACE;
            end
         5'd14: 
            begin           
                if(flag)
                    keycode_14 <= lcdcode;
                else 
                    keycode_14 <= keycode_14;
                	keycode_15 <= SPACE;
            end
          5'd15: 
            begin           
                if(flag)
                    keycode_15 <= lcdcode;
                else 
                    keycode_15 <= keycode_15;
                	keycode_16 <= SPACE;
            end
         5'd16: 
            begin           
                if(flag)
                    keycode_16 <= lcdcode;
                else 
                    keycode_16 <= keycode_16;
                	keycode_17 <= SPACE;
            end
         5'd17: 
            begin           
                if(flag)
                    keycode_17 <= lcdcode;
                else 
                    keycode_17 <= keycode_17;
                	keycode_18 <= SPACE;
            end
         5'd18: 
            begin           
                if(flag)
                    keycode_18 <= lcdcode;
                else 
                    keycode_18 <= keycode_18;
                	keycode_19 <= SPACE;
            end
        5'd19: 
            begin           
                if(flag)
                    keycode_19 <= lcdcode;
                else 
                    keycode_19 <= keycode_19;
                	keycode_20 <= SPACE;
            end
         5'd20: 
            begin           
                if(flag)
                    keycode_20 <= lcdcode;
                else 
                    keycode_20 <= keycode_20;
                	keycode_21 <= SPACE;
            end
        5'd21: 
            begin           
                if(flag)
                    keycode_21 <= lcdcode;
                else 
                    keycode_21 <= keycode_21;
                	keycode_22 <= SPACE;
            end
         5'd22: 
            begin           
                if(flag)
                    keycode_22 <= lcdcode;
                else 
                    keycode_22 <= keycode_22;
                	keycode_23 <= SPACE;
            end
        5'd23: 
            begin           
                if(flag)
                    keycode_23 <= lcdcode;
                else 
                    keycode_23 <= keycode_23;
                	keycode_24 <= SPACE;
            end
        5'd24: 
            begin           
                if(flag)
                    keycode_24 <= lcdcode;
                else 
                    keycode_24 <= keycode_24;
                	keycode_25 <= SPACE;
            end
        5'd25: 
            begin           
                if(flag)
                    keycode_25 <= lcdcode;
                else 
                    keycode_25 <= keycode_25;
                	keycode_26 <= SPACE;
            end
        5'd26: 
            begin           
                if(flag)
                    keycode_26 <= lcdcode;
            end
        endcase
        
	always @ (*)                                        
    begin
            case(address)
                //  LCD��һ����ʾ������
                5'd0:   dataram = keycode_1; 
                5'd1:   dataram = keycode_2;
                5'd2:   dataram = keycode_3;          
                5'd3:   dataram = keycode_4;           
                5'd4:   dataram = keycode_5;        
               	5'd5:   dataram = keycode_6;                        
				5'd6:   dataram = keycode_7;       
                5'd7:   dataram = keycode_8;    
                5'd8:   dataram = keycode_9;
                5'd9:   dataram = keycode_10;    
                5'd10:  dataram = keycode_11;    
                5'd11:  dataram = keycode_12;    
                5'd12:  dataram = keycode_13;
                5'd13:  dataram = SPACE;    
                //  LCD�ڶ�����ʾ������
                5'd14:  dataram = keycode_14;
                5'd15:  dataram = keycode_15;
                5'd16:  dataram = keycode_16;   
                5'd17:  dataram = keycode_17;    
                5'd18:  dataram = keycode_18;    
                5'd19:  dataram = keycode_19;    
                5'd20:  dataram = keycode_20;    
                5'd21:  dataram = keycode_21;    
                5'd22:  dataram = keycode_22;    
                5'd23:  dataram = keycode_23;
                5'd24:  dataram = keycode_24;    
                5'd25:  dataram = keycode_25;    
                5'd26:  dataram = keycode_26;    
                5'd27:  dataram = SPACE;
                default:dataram = SPACE;
            endcase
    end
	
    always @(clk4800hz) 
    begin
    en=clk4800hz;
    end

    assign rw = 0;
	
	
    always @(posedge en or negedge rst_n)
    begin 
        if(!rst_n)
            begin
                CS <= CLEAR;
                address <= 5'b00000;                      //	��ʾ�ַ��׵�ַ;
            end
        else
            case(CS)
   
            CLEAR:                                      //  ����״̬
                    begin
                        data <= 8'b00000001;
                        rs <= 0;         
                        CS <= INPUTSET;
                    end
            INPUTSET:                                   //	����Զ����ƣ�
                    begin
                        data <= 8'b00000110;
                        rs <= 0;              
                        CS <= FUNCTIONSET;
                    end
            FUNCTIONSET:                                //	8λ��·�ߡ�˫����ʾ��5x7����
                    begin
                        data <= 8'b00111000;
                        rs <= 0;                
                        CS <= DISPLAYSWITCH;
                    end
            DISPLAYSWITCH:                              //	����ʾ�������˸��
                    begin
                        data <= 8'b00001100;
                        rs <= 0;                   
                        CS <= DDRAM1;
                    end             
            DDRAM1:                                     //	LCD��һ�е�ַ;
                    begin
                        data <= 8'b10000000;
                        rs <= 0;          
                        CS <= DATAWRITE1;
                    end
            DATAWRITE1:                                  //	д����״̬;
                   begin
                        if(address<5'd14)               //  д��һ������
                            begin
                                data <= dataram;
                                rs <= 1;       
                                address <= address+1'b1;  //  ͨ���ӵ�ַ��ʾ��һ���ַ�
                                CS <= DATAWRITE1;
                            end
                        else 
                            CS <= DDRAM2;
                    end                                   
                            
            DDRAM2:                                     //	LCD�ڶ��е�ַ;
                    begin
                        data<= 8'b11000000;
                        rs <= 0;
                        CS <= DATAWRITE2;
                    end   
            DATAWRITE2:                                 //  д�ڶ�������
                    begin
                        if(address >= 5'd14 && address <= 5'd27)
                            begin
                                data <= dataram;
                                rs <= 1;
                                address <= address + 1'b1;  //  ͨ���ӵ�ַ��ʾ��һ���ַ�
                                CS <= DATAWRITE2;
                            end 
                        else if(address > 5'd27)          //  д���ַ��ٻ�ͷд
                            begin
                                CS <= INPUTSET;
                                address <= 1'b0;
                            end
                    end                            
            default:
                    CS <= CLEAR;
            endcase
    end
    assign keyvalue_o=keyvalue;
    assign shift_o = shift;
endmodule