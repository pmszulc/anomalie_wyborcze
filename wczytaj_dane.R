## 2015

# 1. tura

wyb15_obw1 <- readxl::read_excel("data/2015/wyniki_tura1.xls", na = c("", "-"))
names(wyb15_obw1)[c(8, 25, 26)] <- paste0(c("Nupr", "Nniew", "N"), "_1")
names(wyb15_obw1)[28:38] <- paste0(c("Braun", "Duda", "Jarubas", "Komorowski",
  "Korwin", "Kowalski", "Kukiz", "Ogórek", "Palikot", "Tanajno", "Wilk"), "_1") 
# Kod gminy był podany jako formuła i był problem z wczytaniem, zmodyfikowałem
# plik excel

wyb15_obw1 <- wyb15_obw1 %>% 
  rename(Komisja = `Numer obwodu`, Kod = `TERYT gminy`) %>% 
  select(Kod, Komisja, Gmina, Województwo, Siedziba,
    Nupr_1, N_1, Nniew_1, Braun_1:Wilk_1) %>% 
  mutate(Kod = str_remove_all(Kod, fixed("\"")))

# 2. tura

wyb15_obw2 <- readxl::read_excel("data/2015/wyniki_tura2.xls", na = c("", "-"))
names(wyb15_obw2)[c(5, 22, 23)] <- paste0(c("Nupr", "Nniew", "N"), "_2")
names(wyb15_obw2)[24:25] <- paste0(c("Duda", "Komorowski"), "_2") 

wyb15_obw2 <- wyb15_obw2 %>% 
  rename(Komisja = `Numer obwodu`, Kod = `TERYT gminy`) %>% 
  select(Kod, Komisja, Nupr_2, N_2, Nniew_2, Duda_2, Komorowski_2) %>% 
  mutate(Kod = str_remove_all(Kod, fixed("\"")))

wyb15 <- full_join(wyb15_obw1, wyb15_obw2) %>% 
  mutate(across(Nupr_1:Komorowski_2, ~ ifelse(is.na(.), 0, .)))

wyb15proc <- wyb15 %>% 
  filter(N_1 > 0, N_2 > 0) %>% 
  mutate(across(Nniew_1:Wilk_1, ~ . / N_1 * 100)) %>%
  mutate(across(Nniew_2:Komorowski_2, ~ . / N_2 * 100))
## 2020

# 1. tura

wyb20_obw1 <- read_csv2("data/2020/wyniki_gl_na_kand_po_obwodach_1tura.csv",
  na = c("", "-"))
names(wyb20_obw1)[c(13, 29, 30, 31, 33)] <- 
  paste0(c("Nupr", "Nniew", "Nniew2x", "Nniew0x", "N"), "_1")
names(wyb20_obw1)[34:44] <- paste0(c("Biedroń", "Bosak", "Duda", "Hołownia", "Jakubiak",
  "Kamysz", "Piotrowski", "Tanajno", "Trzaskowski", "Witkowski", "Żółtek"), "_1") 

wyb20_obw1 <- wyb20_obw1 %>% 
  rename(Kod = `Kod TERYT`, Komisja = `Numer obwodu`) %>% 
  select(Kod, Komisja, Gmina, Powiat, Województwo, `Typ obszaru`:Siedziba,
    Nupr_1, N_1, Nniew_1, Nniew2x_1, Nniew0x_1, Biedroń_1:Żółtek_1) %>% 
  mutate(Kod = as.character(Kod)) %>% 
  mutate(Kod = ifelse(str_length(Kod) == 5, paste0("0", Kod), Kod))

# 2. tura

wyb20_obw2 <- read_csv2("data/2020/wyniki_gl_na_kand_po_obwodach_2tura.csv",
  na = c("", "-"))
names(wyb20_obw2)[c(13, 29, 30, 31, 33)] <- 
  paste0(c("Nupr", "Nniew", "Nniew2x", "Nniew0x", "N"), "_2")
names(wyb20_obw2)[34:35] <- paste0(c("Duda", "Trzaskowski"), "_2") 

wyb20_obw2 <- wyb20_obw2 %>% 
  rename(Kod = `Kod TERYT`, Komisja = `Numer obwodu`) %>% 
  select(Kod, Komisja, Nupr_2, N_2, Nniew_2, Nniew2x_2, Nniew0x_2, 
    Duda_2, Trzaskowski_2) %>% 
  mutate(Kod = as.character(Kod)) %>% 
  mutate(Kod = ifelse(str_length(Kod) == 5, paste0("0", Kod), Kod))

wyb20 <- full_join(wyb20_obw1, wyb20_obw2) %>% 
  mutate(across(Nupr_1:Trzaskowski_2, ~ ifelse(is.na(.), 0, .))) %>% 
  rename(Typ_obszaru = `Typ obszaru`, Typ_obwodu = `Typ obwodu`)

wyb20proc <- wyb20 %>% 
  filter(N_1 > 0, N_2 > 0) %>% 
  mutate(across(Nniew_1:Żółtek_1, ~ . / N_1 * 100)) %>%
  mutate(across(Nniew_2:Trzaskowski_2, ~ . / N_2 * 100))


## 2025

# 1. tura

wyb25_obw1 <- read_csv2("data/2025/protokoly_po_obwodach_1tura.csv")
names(wyb25_obw1)[c(11, 28, 29, 30, 32)] <- 
  paste0(c("Nupr", "Nniew", "Nniew2x", "Nniew0x", "N"), "_1")
names(wyb25_obw1)[33:45] <- paste0(c("Bartoszewicz", "Biejat", "Braun", "Hołownia",
  "Jakubiak", "Maciak", "Mentzen", "Nawrocki", "Senyszyn", "Stanowski", "Trzaskowski",
  "Woch", "Zandberg"), "_1") 

wyb25_obw1 <- wyb25_obw1 %>% 
  rename(Kod = `Teryt Gminy`, Komisja = `Nr komisji`) %>% 
  select(Kod, Komisja, Gmina, Powiat, Województwo:`Typ obszaru`, Nupr_1, N_1, Nniew_1,
    Nniew2x_1, Nniew0x_1, Bartoszewicz_1:Zandberg_1) %>% 
  mutate(Kod = as.character(Kod)) %>% 
  mutate(Kod = ifelse(str_length(Kod) == 5, paste0("0", Kod), Kod))

# 2. tura

wyb25_obw2 <- read_csv2("data/2025/protokoly_po_obwodach_2tura.csv")
names(wyb25_obw2)[c(11, 28, 29, 30, 31)] <- 
  paste0(c("Nupr", "Nniew", "Nniew2x", "Nniew0x", "N"), "_2")
names(wyb25_obw2)[32:33] <- paste0(c("Nawrocki","Trzaskowski"), "_2") 

wyb25_obw2 <- wyb25_obw2 %>% 
  rename(Kod = `Teryt Gminy`, Komisja = `Nr komisji`) %>% 
  select(Kod, Komisja, Nupr_2, N_2, Nniew_2, Nniew2x_2, Nniew0x_2,
    Nawrocki_2, Trzaskowski_2) %>% 
  mutate(Kod = as.character(Kod)) %>% 
  mutate(Kod = ifelse(str_length(Kod) == 5, paste0("0", Kod), Kod))

wyb25 <- full_join(wyb25_obw1, wyb25_obw2) %>% 
  mutate(across(Nupr_1:Trzaskowski_2, ~ ifelse(is.na(.), 0, .))) %>% 
  rename(Typ_obszaru = `Typ obszaru`, Typ_obwodu = `Typ obwodu`)

wyb25proc <- wyb25 %>% 
  filter(N_1 > 0, N_2 > 0) %>% 
  mutate(across(Nniew_1:Zandberg_1, ~ . / N_1 * 100)) %>%
  mutate(across(Nniew_2:Trzaskowski_2, ~ . / N_2 * 100))
