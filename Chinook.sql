-- Chinook Music Store Database
DROP DATABASE IF EXISTS Chinook;
CREATE DATABASE Chinook;
USE Chinook;

-- Artist table
CREATE TABLE Artist (
    ArtistId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(120)
);

-- Album table
CREATE TABLE Album (
    AlbumId INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(160) NOT NULL,
    ArtistId INT NOT NULL,
    FOREIGN KEY (ArtistId) REFERENCES Artist(ArtistId)
);

-- Genre table
CREATE TABLE Genre (
    GenreId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(120)
);

-- MediaType table
CREATE TABLE MediaType (
    MediaTypeId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(120)
);

-- Track table
CREATE TABLE Track (
    TrackId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(200) NOT NULL,
    AlbumId INT,
    MediaTypeId INT NOT NULL,
    GenreId INT,
    Composer VARCHAR(220),
    Milliseconds INT NOT NULL,
    Bytes INT,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (AlbumId) REFERENCES Album(AlbumId),
    FOREIGN KEY (MediaTypeId) REFERENCES MediaType(MediaTypeId),
    FOREIGN KEY (GenreId) REFERENCES Genre(GenreId)
);

-- Employee table
CREATE TABLE Employee (
    EmployeeId INT PRIMARY KEY AUTO_INCREMENT,
    LastName VARCHAR(20) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    Title VARCHAR(30),
    ReportsTo INT,
    BirthDate DATETIME,
    HireDate DATETIME,
    Address VARCHAR(70),
    City VARCHAR(40),
    State VARCHAR(40),
    Country VARCHAR(40),
    PostalCode VARCHAR(10),
    Phone VARCHAR(24),
    Fax VARCHAR(24),
    Email VARCHAR(60),
    FOREIGN KEY (ReportsTo) REFERENCES Employee(EmployeeId)
);

-- Customer table
CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(40) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Company VARCHAR(80),
    Address VARCHAR(70),
    City VARCHAR(40),
    State VARCHAR(40),
    Country VARCHAR(40),
    PostalCode VARCHAR(10),
    Phone VARCHAR(24),
    Fax VARCHAR(24),
    Email VARCHAR(60) NOT NULL,
    SupportRepId INT,
    FOREIGN KEY (SupportRepId) REFERENCES Employee(EmployeeId)
);

-- Invoice table
CREATE TABLE Invoice (
    InvoiceId INT PRIMARY KEY AUTO_INCREMENT,
    CustomerId INT NOT NULL,
    InvoiceDate DATETIME NOT NULL,
    BillingAddress VARCHAR(70),
    BillingCity VARCHAR(40),
    BillingState VARCHAR(40),
    BillingCountry VARCHAR(40),
    BillingPostalCode VARCHAR(10),
    Total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

-- InvoiceLine table
CREATE TABLE InvoiceLine (
    InvoiceLineId INT PRIMARY KEY AUTO_INCREMENT,
    InvoiceId INT NOT NULL,
    TrackId INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (InvoiceId) REFERENCES Invoice(InvoiceId),
    FOREIGN KEY (TrackId) REFERENCES Track(TrackId)
);

-- Playlist table
CREATE TABLE Playlist (
    PlaylistId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(120)
);

-- PlaylistTrack table
CREATE TABLE PlaylistTrack (
    PlaylistId INT NOT NULL,
    TrackId INT NOT NULL,
    PRIMARY KEY (PlaylistId, TrackId),
    FOREIGN KEY (PlaylistId) REFERENCES Playlist(PlaylistId),
    FOREIGN KEY (TrackId) REFERENCES Track(TrackId)
);

-- Insert sample data

-- Artists
INSERT INTO Artist (Name) VALUES 
('AC/DC'), ('Accept'), ('Aerosmith'), ('Alanis Morissette'), ('Alice In Chains'),
('Antônio Carlos Jobim'), ('Apocalyptica'), ('Audioslave'), ('BackBeat'), ('Billy Cobham'),
('Black Label Society'), ('Black Sabbath'), ('Body Count'), ('Bruce Dickinson'), ('Buddy Guy'),
('Caetano Veloso'), ('Chico Buarque'), ('Chico Science & Nação Zumbi'), ('Cidade Negra'), ('Cláudio Zoli');

-- Albums
INSERT INTO Album (Title, ArtistId) VALUES 
('For Those About To Rock We Salute You', 1), ('Balls to the Wall', 2), ('Restless and Wild', 2),
('Let There Be Rock', 1), ('Big Ones', 3), ('Jagged Little Pill', 4), ('Facelift', 5),
('Warner 25 Anos', 6), ('Plays Metallica By Four Cellos', 7), ('Audioslave', 8),
('Out Of Exile', 8), ('BackBeat Soundtrack', 9), ('The Best Of Billy Cobham', 10),
('Alcohol Fueled Brewtality Live!! [Disc 1]', 11), ('Alcohol Fueled Brewtality Live!! [Disc 2]', 11),
('Black Sabbath', 12), ('Black Sabbath Vol. 4 (Remaster)', 12), ('Body Count', 13),
('Chemical Wedding', 14), ('The Best Of Buddy Guy - The Millenium Collection', 15);

-- Genres
INSERT INTO Genre (Name) VALUES 
('Rock'), ('Jazz'), ('Metal'), ('Alternative & Punk'), ('Rock And Roll'),
('Blues'), ('Latin'), ('Reggae'), ('Pop'), ('Soundtrack'),
('Bossa Nova'), ('Easy Listening'), ('Heavy Metal'), ('R&B/Soul'), ('Electronica/Dance'),
('World'), ('Hip Hop/Rap'), ('Science Fiction'), ('TV Shows'), ('Sci Fi & Fantasy'),
('Drama'), ('Comedy'), ('Alternative'), ('Classical'), ('Opera');

-- MediaTypes
INSERT INTO MediaType (Name) VALUES 
('MPEG audio file'), ('Protected AAC audio file'), ('Protected MPEG-4 video file'),
('Purchased AAC audio file'), ('AAC audio file');

-- Tracks (sample)
INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice) VALUES
('For Those About To Rock (We Salute You)', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 343719, 11170334, 0.99),
('Balls to the Wall', 2, 2, 1, NULL, 342562, 5510424, 0.99),
('Fast As a Shark', 3, 2, 1, 'F. Baltes, S. Kaufman, U. Dirkscneider & W. Hoffman', 230619, 3990994, 0.99),
('Restless and Wild', 3, 2, 1, 'F. Baltes, R.A. Smith-Diesel, S. Kaufman, U. Dirkscneider & W. Hoffman', 252051, 4331779, 0.99),
('Princess of the Dawn', 3, 2, 1, 'Deaffy & R.A. Smith-Diesel', 375418, 6290521, 0.99),
('Put The Finger On You', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 205662, 6713451, 0.99),
('Let''s Get It Up', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 233926, 7636561, 0.99),
('Inject The Venom', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 210834, 6852860, 0.99),
('Snowballed', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 203102, 6599424, 0.99),
('Evil Walks', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 263497, 8611245, 0.99);

-- Employees
INSERT INTO Employee (LastName, FirstName, Title, ReportsTo, BirthDate, HireDate, Address, City, State, Country, PostalCode, Phone, Email) VALUES
('Adams', 'Andrew', 'General Manager', NULL, '1962-02-18', '2002-08-14', '11120 Jasper Ave NW', 'Edmonton', 'AB', 'Canada', 'T5K 2N1', '+1 (780) 428-9482', 'andrew@chinookcorp.com'),
('Edwards', 'Nancy', 'Sales Manager', 1, '1958-12-08', '2002-05-01', '825 8 Ave SW', 'Calgary', 'AB', 'Canada', 'T2P 2T3', '+1 (403) 262-3443', 'nancy@chinookcorp.com'),
('Peacock', 'Jane', 'Sales Support Agent', 2, '1973-08-29', '2002-04-01', '1111 6 Ave SW', 'Calgary', 'AB', 'Canada', 'T2P 5M5', '+1 (403) 262-3443', 'jane@chinookcorp.com'),
('Park', 'Margaret', 'Sales Support Agent', 2, '1947-09-19', '2003-05-03', '683 10 Street SW', 'Calgary', 'AB', 'Canada', 'T2P 5G3', '+1 (403) 263-4423', 'margaret@chinookcorp.com'),
('Johnson', 'Steve', 'Sales Support Agent', 2, '1965-03-03', '2003-10-17', '7727B 41 Ave', 'Calgary', 'AB', 'Canada', 'T3B 1Y7', '1 (780) 836-9987', 'steve@chinookcorp.com');

-- Customers (sample)
INSERT INTO Customer (FirstName, LastName, Company, Address, City, State, Country, PostalCode, Phone, Email, SupportRepId) VALUES
('Luís', 'Gonçalves', 'Embraer - Empresa Brasileira de Aeronáutica S.A.', 'Av. Brigadeiro Faria Lima, 2170', 'São José dos Campos', 'SP', 'Brazil', '12227-000', '+55 (12) 3923-5555', 'luisg@embraer.com.br', 3),
('Leonie', 'Köhler', NULL, 'Theodor-Heuss-Straße 34', 'Stuttgart', NULL, 'Germany', '70174', '+49 0711 2842222', 'leonekohler@surfeu.de', 5),
('François', 'Tremblay', NULL, '1498 rue Bélanger', 'Montréal', 'QC', 'Canada', 'H2G 1A7', '+1 (514) 721-4711', 'ftremblay@gmail.com', 3),
('Bjørn', 'Hansen', NULL, 'Ullevålsveien 14', 'Oslo', NULL, 'Norway', '0171', '+47 22 44 22 22', 'bjorn.hansen@yahoo.no', 4),
('František', 'Wichterlová', 'JetBrains s.r.o.', 'Klanova 9/506', 'Prague', NULL, 'Czech Republic', '14700', '+420 2 4172 5555', 'frantisekw@jetbrains.com', 4);

-- Invoices
INSERT INTO Invoice (CustomerId, InvoiceDate, BillingAddress, BillingCity, BillingState, BillingCountry, BillingPostalCode, Total) VALUES
(1, '2009-01-01', 'Av. Brigadeiro Faria Lima, 2170', 'São José dos Campos', 'SP', 'Brazil', '12227-000', 1.98),
(2, '2009-01-02', 'Theodor-Heuss-Straße 34', 'Stuttgart', NULL, 'Germany', '70174', 3.96),
(3, '2009-01-03', '1498 rue Bélanger', 'Montréal', 'QC', 'Canada', 'H2G 1A7', 5.94),
(4, '2009-01-06', 'Ullevålsveien 14', 'Oslo', NULL, 'Norway', '0171', 8.91),
(5, '2009-01-11', 'Klanova 9/506', 'Prague', NULL, 'Czech Republic', '14700', 13.86);

-- InvoiceLines
INSERT INTO InvoiceLine (InvoiceId, TrackId, UnitPrice, Quantity) VALUES
(1, 1, 0.99, 1), (1, 2, 0.99, 1),
(2, 3, 0.99, 1), (2, 4, 0.99, 1), (2, 5, 0.99, 1), (2, 6, 0.99, 1),
(3, 7, 0.99, 1), (3, 8, 0.99, 1), (3, 9, 0.99, 1), (3, 10, 0.99, 1);

-- Playlists
INSERT INTO Playlist (Name) VALUES 
('Music'), ('Movies'), ('TV Shows'), ('Audiobooks'), ('90's Music'),
('Brazilian Music'), ('Classical'), ('Classical 101 - Deep Cuts'), ('Classical 101 - Next Steps'), ('Classical 101 - The Basics');

-- PlaylistTrack (sample associations)
INSERT INTO PlaylistTrack (PlaylistId, TrackId) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(5, 1), (5, 3), (5, 7), (5, 9);

-- Summary
SELECT 'Chinook Database created successfully!' AS Status;
SELECT COUNT(*) AS Total_Artists FROM Artist;
SELECT COUNT(*) AS Total_Albums FROM Album;
SELECT COUNT(*) AS Total_Tracks FROM Track;
SELECT COUNT(*) AS Total_Customers FROM Customer;
SELECT COUNT(*) AS Total_Invoices FROM Invoice;