-- Proste zapytania do jednej tablicy
-- 1. Wyświetlenie wszystkich danych z tabeli Gracze
SELECT * 
FROM Gracze;

-- 2. Wyświetlenie graczy z pozycji "Libero"
SELECT * 
FROM Gracze 
WHERE pozycja = 'Libero';

-- 3. Zliczenie graczy według ich pozycji
SELECT pozycja, COUNT(*) AS liczba_graczy 
FROM Gracze 
GROUP BY pozycja;

-- 4. Wyświetlenie graczy urodzonych po 2000 roku
SELECT * 
FROM Gracze 
WHERE data_urodzenia > '2000-01-01';

-- Zapytania z użyciem JOIN
-- 5. Lista drużyn wraz z ich trenerami
SELECT d.nazwa AS Drużyna, t.imie AS Trener, t.nazwisko AS TrenerNazwisko
FROM InfoDruzyny d
INNER JOIN Trenery t ON d.id_trenera = t.id_trenera;

-- 6. Wyniki gier z nazwami drużyn
SELECT g.numer_gry, d1.nazwa AS PierwszaDrużyna, d2.nazwa AS DrugaDrużyna, g.czas_meczu
FROM Gierki_Ligy_Siatkarskej g
INNER JOIN InfoDruzyny d1 ON g.id_pierwszej_druzyny = d1.id_druzyny
INNER JOIN InfoDruzyny d2 ON g.id_drugiej_druzyny = d2.id_druzyny;

-- 7. Lista gier z sędziami prowadzącymi
SELECT g.numer_gry, g.czas_meczu, s.imie AS Sedzia, s.nazwisko AS SedziaNazwisko
FROM Gierki_Ligy_Siatkarskej g
INNER JOIN Sedziowie s ON g.id_sedziego = s.id_sedziego;

-- 8. Drużyny ze sponsorami
SELECT d.nazwa AS Drużyna, s.nazwa AS Sponsor
FROM InfoDruzyny d
INNER JOIN Sponsory_Druzyny s ON d.id_druzyny = s.id_druzyny;

-- Zapytania z podzapytaniem w części SELECT
-- 9. Wyświetlenie średniej liczby gier na drużynę
SELECT nazwa, (SELECT COUNT(*) 
FROM Gierki_Ligy_Siatkarskej g 
WHERE g.id_pierwszej_druzyny = d.id_druzyny OR g.id_drugiej_druzyny = d.id_druzyny) AS liczba_gier
FROM InfoDruzyny d;

-- 10. Najlepszy wynik gier dla każdej drużyny
SELECT nazwa, (SELECT MAX(punkty_serwow) 
FROM StatystykiDruzyny s 
WHERE s.id_druzyny = d.id_druzyny) AS najlepszy_serwis
FROM InfoDruzyny d;

-- 11. Sędzia z największą liczbą gier
SELECT imie, nazwisko, (SELECT COUNT(*) 
FROM Gierki_Ligy_Siatkarskej g 
WHERE g.id_sedziego = s.id_sedziego) AS liczba_gier
FROM Sedziowie s;

-- Zapytania z podzapytaniem w części FROM
-- 12. Lista sędziów zliczających mecze
SELECT s.imie, s.nazwisko, g.liczba_gier
FROM Sedziowie s
INNER JOIN (SELECT id_sedziego, COUNT(*) AS liczba_gier 
FROM Gierki_Ligy_Siatkarskej 
GROUP BY id_sedziego) g
ON s.id_sedziego = g.id_sedziego;

-- 13. Drużyny z maksymalną liczbą zawodników
SELECT nazwa, maksymalna_liczba_zawodników
FROM InfoDruzyny d
INNER JOIN (SELECT id_druzyny, MAX(ilość_zawodników) AS maksymalna_liczba_zawodników 
FROM StatystykiDruzyny 
GROUP BY id_druzyny) s
ON d.id_druzyny = s.id_druzyny;

-- 14. Sponsorzy z największym wkładem
SELECT s.nazwa AS Sponsor, d.towary AS Towar, MAX(d.cena) AS MaksymalnaCena
FROM Sponsory_Druzyny s
INNER JOIN Dochody_Wydatki d ON s.nazwa = d.firma_sprzedaży
GROUP BY s.nazwa, d.towary;

-- 15. Gracze z najwyższymi statystykami
SELECT g.imie, g.nazwisko, statystyki.punkty_ataku
FROM Gracze g
INNER JOIN (SELECT id_gracza, MAX(punkty_ataku) AS punkty_ataku 
FROM StatystykiGracza 
GROUP BY id_gracza) statystyki
ON g.id_gracza = statystyki.id_gracza;

-- Zapytania z podzapytaniem w części WHERE
-- 16. Lista drużyn, które zagrały więcej niż 5 meczów
SELECT nazwa
FROM InfoDruzyny d
WHERE (SELECT COUNT(*) 
FROM Gierki_Ligy_Siatkarskej g 
WHERE g.id_pierwszej_druzyny = d.id_druzyny OR g.id_drugiej_druzyny = d.id_druzyny) > 5;

-- 17. Drużyny z co najmniej jednym sponsorem
SELECT nazwa
FROM InfoDruzyny d
WHERE EXISTS (SELECT 1 
FROM Sponsory_Druzyny s 
WHERE s.id_druzyny = d.id_druzyny);

-- 18. Gracze, którzy rozegrali mniej niż 3 mecze
SELECT imie, nazwisko
FROM Gracze g
WHERE (SELECT COUNT(*) 
FROM PozycjeDruzyny p 
WHERE p.atakujacy = g.id_gracza OR p.libero = g.id_gracza) < 3;

-- 19. Mecze rozgrywane przez drużynę, która wygrała więcej niż 2 mecze
SELECT numer_gry, czas_meczu
FROM Gierki_Ligy_Siatkarskej g
WHERE (SELECT COUNT(*) 
FROM Gierki_Ligy_Siatkarskej 
WHERE id_wygrywającej_druzyny = g.id_wygrywającej_druzyny) > 2;

-- Funkcje okna
-- 20. Ranking drużyn na podstawie liczby zwycięstw
SELECT nazwa, ROW_NUMBER() OVER (ORDER BY liczba_zwycięstw DESC) AS Miejsce
FROM (SELECT nazwa, (SELECT COUNT(*) 
FROM Gierki_Ligy_Siatkarskej g 
WHERE g.id_wygrywającej_druzyny = d.id_druzyny) AS liczba_zwycięstw
FROM InfoDruzyny d) ranking;

-- 21. Gracze z największą ilością punktów ataku
SELECT imie, nazwisko, RANK() OVER (ORDER BY punkty_ataku DESC) AS Ranking
FROM (SELECT g.imie, g.nazwisko, s.punkty_ataku
FROM Gracze g
INNER JOIN StatystykiGracza s ON g.id_gracza = s.id_gracza) gracze;

-- 22. Statystyki drużyn w turnieju z użyciem funkcji PARTITION BY
SELECT nazwa, SUM(punkty_ataku) OVER (PARTITION BY nazwa) AS SumaPunktów
FROM InfoDruzyny d
INNER JOIN StatystykiDruzyny s ON d.id_druzyny = s.id_druzyny;

-- 23. Maksymalna liczba gier rozegranych przez drużynę
SELECT nazwa, MAX(liczba_gier) OVER () AS MaksymalnaLiczbaGier
FROM (SELECT nazwa, (SELECT COUNT(*) 
FROM Gierki_Ligy_Siatkarskej g 
WHERE g.id_pierwszej_druzyny = d.id_druzyny OR g.id_drugiej_druzyny = d.id_druzyny) AS liczba_gier
FROM InfoDruzyny d) gierki;

-- 24. Wyświetlenie drużyn i ich trenerów, w tym drużyn bez przypisanych trenerów
SELECT d.nazwa AS Drużyna, t.imie AS Trener, t.nazwisko AS NazwiskoTrenera
FROM InfoDruzyny d
LEFT JOIN Trenery t ON d.id_trenera = t.id_trenera;

-- 25. Lista gier z nazwami drużyn i sędziami, w tym gier bez przypisanych sędziów
SELECT g.numer_gry, d1.nazwa AS PierwszaDrużyna, d2.nazwa AS DrugaDrużyna, s.imie AS Sedzia, s.nazwisko AS NazwiskoSedziego
FROM Gierki_Ligy_Siatkarskej g
LEFT JOIN InfoDruzyny d1 ON g.id_pierwszej_druzyny = d1.id_druzyny
LEFT JOIN InfoDruzyny d2 ON g.id_drugiej_druzyny = d2.id_druzyny
LEFT JOIN Sedziowie s ON g.id_sedziego = s.id_sedziego;

-- 26. Lista sponsorów drużyn, w tym drużyn bez sponsorów
SELECT d.nazwa AS Drużyna, s.nazwa AS Sponsor
FROM InfoDruzyny d
LEFT JOIN Sponsory_Druzyny s ON d.id_druzyny = s.id_druzyny;

-- 27. Gracze i ich statystyki, w tym gracze bez przypisanych statystyk
SELECT g.imie, g.nazwisko, s.procent_ataku, s.procent_przyjec, s.procent_serwow
FROM Gracze g
LEFT JOIN StatystykiGracza s ON g.id_gracza = s.id_gracza;
