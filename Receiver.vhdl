library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Receiver is
    port ( RXD, DSR, CTS, DCD, clk, enable: in std_logic;
           Data: in std_logic_vector(7 downto 0);
           TXD: out std_logic := '1';
           DTR, RTS: out std_logic);
end Receiver;

architecture behavioral of Receiver is

    signal incountR: unsigned(3 downto 0) := "1101";
    signal sRTS, ready_RTS, start: std_logic := '0';
    signal protocol: std_logic_vector(11 downto 0);

    begin

        RTS <= sRTS;
        ready_RTS <= sRTS after 1 ns;
        
        process
            begin
                wait until (clk'event and clk = '0');

                --Confirmar al DTE que se está listo para la comunicación
                if DSR = '1' then
                    DTR <= '1';

                    elsif DSR = '0' then
                        DTR <= '0';

                    else null;
                end if;

                --Confirmar al DTE que se está recibir la información
                if CTS = '1' then
                    sRTS <= '1';

                    elsif CTS = '0' then
                        sRTS <= '0';

                    else null;
                end if;

                --Leer
                if (RXD = '0') and (start = '0')then
                    start <= '1';
                    protocol(to_integer(incountR - 1)) <= RXD;
                    incountR <= incountR - 1;

                    elsif (start = '1') and (incountR < "0000") then
                        protocol(to_integer(incountR)) <= RXD;
                        incountR <= incountR + 1;

                    elsif incountR = "0000" then
                        start <= '0';
                        incountR <= "1101";
                end if;

        end process;        

end behavioral;