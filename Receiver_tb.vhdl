library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Receiver_tb is
end Receiver_tb;

architecture arch of ent is

    component Receiver is
        port ( RXD, DSR, CTS, DCD, clk, enable: in std_logic;
               Data: in std_logic_vector(7 downto 0);
               TXD: out std_logic := '1';
               DTR, RTS: out std_logic);
    end component;

    signal DSR_s, CTS_s, DCD_s, clk_s, enable_s, DTR_s, RTS_s: std_logic := '0';
    signal RXD_s, TXD_s: std_logic := '1';
    signal Data_s: std_logic_vector(7 downto 0);

    begin

        R: Receiver port map (RXD_s, DSR_s, CTS_s, DCD_s, clk_s, enable_s, Data_s, TXD_s, DTR_s, RTS_s);

        process
            begin

                wait for 1 ns;
                clk_s <= '1';

                wait for 1 ns;
                clk_s <= '0';

        end process;

        process
            begin

                wait for 1 ns; 
                DSR_s <= '1';

                wait for 2 ns; 
                CTS_s <= '1';

                wait for 2 ns; --1
                RXD_s <= '0';

                wait for 2 ns; --2
                RXD_s <= '0';

                wait for 2 ns; --3
                RXD_s <= '1';

                wait for 2 ns; --4
                RXD_s <= '0';

                wait for 2 ns; --5
                RXD_s <= '1';

                wait for 2 ns; --6
                RXD_s <= '0';

                wait for 2 ns; --7
                RXD_s <= '0';

                wait for 2 ns; --8
                RXD_s <= '1';

                wait for 2 ns; --9
                RXD_s <= '0';

                wait for 2 ns; --10
                RXD_s <= '1';

                wait for 2 ns; --11
                RXD_s <= '1';

                wait for 2 ns; --12
                RXD_s <= '1';

        end process;
end arch;