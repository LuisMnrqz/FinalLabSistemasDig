library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Transceiver is
    port ( RXD, DSR, CTS, DCD, clk, enable: in std_logic;
           Data: in std_logic_vector(7 downto 0);
           TXD: out std_logic:='1';
           DTR, RTS: out std_logic);
end Transceiver;

architecture Behavioral of Transceiver is

    signal incount, i : unsigned(3 downto 0) := "0000";
    signal parity: std_logic;--valor de la paridad del DATA

    begin

    parity <= data(7) xor(data(6) xor(data(5) xor (data(4) xor(data(3) xor(data(2) xor (data(1) xor(data(0) xor '0')))))));

    process
        begin
            wait until (clk'event and clk = '1');

            -- la señal de enable indica si el cilente quiere que se haga comunicación, cuando se desactiva se finaliza la comunicación.
            if enable = '1' then
                DTR <= '1';

                elsif enable = '0' then
                    DTR <= '0';

                else null;

            end if;

            --Ya que DCE nos indique que esta listo mandamos la peticion para enviar datos.
            if DSR = '1' then
                RTS <= '1';

                elsif DSR = '0' then
                    RTS <= '0';

                else null;

            end if;

            --Ya que el DCE nos indique que esta listo para recivir datos se los enviamos

            if CTS = '1' then

                --como solo enviamos 12 bits el incount va a contar 12 numeros los cuales cada uno indicara que bit estamos mandando
                if incount < "1100" then
                --Se envia el primer bit que es el de comienzo
                    if incount = "0000" then
                        TXD <= '0';
                        --Se envia los bits del Data
                        elsif incount > "0000" and incount < "1001" then
                            TXD <= Data(to_integer(i));
                            i <= i + 1;

                        --Se envia el bit de paridad
                        elsif incount = "1001" then
                            TXD <= parity;

                        --Se finaliza con los bits de parada
                        elsif incount > "1001" and incount < "1011"then
                            TXD <= '1';

                    end if;

                    incount <= incount+1;

                    elsif incount = "1100" then
                        TXD <= '1';
                        incount <= "0000"; 
                        i <= "0000";

                end if;

            end if;

    end process;

end Behavioral;