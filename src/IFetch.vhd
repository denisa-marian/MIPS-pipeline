----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.05.2025 18:58:59
-- Design Name: 
-- Module Name: MEM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;    

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFetch is                                                                                        
  Port ( CLK : in std_logic;                                                                            
         RST : in std_logic;                                                                            
         EN : in std_logic;                                                                             
         Jump : in std_logic;                                                                           
         JumpAddress : in std_logic_vector(31 downto 0);                                                
         BranchAddress : in std_logic_vector(31 downto 0);                                              
         PCSrc : in std_logic;                                                                          
         Instruction : out std_logic_vector(31 downto 0);                                               
         PC4 : out std_logic_vector(31 downto 0));                                                      
end IFetch;                                                                                             
                                                                                                        
architecture Behavioral of IFetch is                                                                    
                                                                                                        
signal Q : std_logic_vector(31 downto 0) := X"00000000";                                                
signal D : std_logic_vector(31 downto 0) := X"00000000";                                                
signal sum : std_logic_vector(31 downto 0):= X"00000000";                                               
signal mux_out : std_logic_vector(31 downto 0);                                                         
                                                                                                        
type mem is array(0 to 31) of std_logic_vector(31 downto 0);                                            
signal ROM_mem : mem := ("00100000000000100000000000001010", -- 0x2002000A: addi $2,$0,10  # $2 = 10 (numar maxim)                        
                        "00000000000000000000100000100000", -- 0x00000820: add $1,$0,$0    # $1 = 0 (contor)                             
                        "00000000000000000001100000100000", -- 0x00001820: add $3,$0,$0    # $3 = 0 (suma)                               
                        "00000000000000000010000000100000", -- 0x00002020: add $4,$0,$0    # $4 = 0 (index memorie)                        
                        "00000000000000000000000000000000", -- noop
                        "00010000001000100000000000001111", -- 0x1022000F: beq $1,$2,15     # if $1==$2, goto end                        
                        "00000000000000000000000000000000", -- noop
                        "00000000000000000000000000000000", -- noop 
                        "10001100100001010000000000000000", -- 0x8C850000: lw $5,0($4)     # $5 = MEM[$4]                                
                        "00110000101001100000000000000001", -- 0x20A60001: andi $6,$5,1    # $6 = $5 & 1 (test paritate)                 
                        "00010000110000000000000000000111", -- 0x10C00007: beq $6,$0,7     # if $6==0 (par), goto add_sum                
                        "00000000000000000000000000000000", -- noop 
                        "00000000000000000000000000000000", -- noop 
                        "00000000000000000000000000000000", -- noop                                                                                                     
                        "00100000001000010000000000000001", -- 0x20010001: addi $1,$1,1    # $1++ (contor)                                                                                                                       
                        "00100000100001000000000000000100", -- 0x21040004: addi $4,$4,4    # $4 += 4 (urmatorul element)                                                                                                         
                        "00001000000000000000000000000101", -- 0x08000005: j loop          # goto loop                                   
                        "00000000000000000000000000000000", -- noop                                                                                         
                        "00000000011001010001100000100000", -- 0x00651820: add $3,$3,$5    # $3 += $5 (adaugare la suma)                                                                                                                    
                        "00100000001000010000000000000001", -- 0x20010001: addi $1,$1,1    # $1++ (contor)                                                                                                                          
                        "00100000100001000000000000000100", -- 0x21040004: addi $4,$4,4    # $4 += 4                                                                                                                                           
                        "00001000000000000000000000000101", -- 0x08000005: j loop          # goto loop                                   
                        "00000000000000000000000000000000", -- noop                                                                                                 
                        "10101100000000110000000001010000", -- 0xAC030050: sw $3,80($0)    # MEM[80] = $3 (salvare suma)begin            
                            others => X"00000000");                                                                                                    
                                                                                                      
begin                                                                                                   
                                                                                                        
    sum <= Q + X"00000004";                                                                             
    PC4 <= sum;                                                                                         
    Instruction <= ROM_mem(conv_integer(Q(6 downto 2)));                                                
                                                                                                        
    mux_out <= BranchAddress when PCSrc = '1' else sum;                                                 
    D <= JumpAddress when Jump = '1' else mux_out;                                                      
                                                                                                        
    PC : process(CLK,RST)                                                                               
    begin                                                                                               
        if RST='1' then Q <= X"00000000";                                                               
        end if;                                                                                         
        if rising_edge(CLK) then                                                                        
            if EN='1' then                                                                              
                Q <= D;                                                                                 
            end if;                                                                                     
        end if;                                                                                         
    end process PC;                                                                                     
                                                                                                                                                                                                                                                                                                          
end Behavioral;