DROP DATABASE IF EXISTS Book_Library_Management;


CREATE DATABASE Book_Library_Management;
USE Book_Library_Management;

-- tac gia
CREATE TABLE Authors (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Aut_name VARCHAR(100) 	-- Ten tac gia
);
-- the loai
CREATE TABLE Category (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Cgr_name VARCHAR(100)	-- Ten loai
);
-- Sach
CREATE TABLE Books(
	ID int AUTO_INCREMENT Primary key,
    Title Nvarchar(100),	-- tieu de
    Author_id int, 			-- Tac gia
    Category_id int,     	-- The loai
    Publication_year Date,	-- nam xuat ban
    Quantity_in_stock int,
    FOREIGN KEY (Author_id) REFERENCES Authors(ID),
    FOREIGN KEY (Category_id) REFERENCES Category(ID)
);
-- Role
CREATE TABLE _Role(
	ID int AUTO_INCREMENT Primary key,
    Role_name Nvarchar(50)
);

-- giao vien
CREATE TABLE Employee(
	ID int AUTO_INCREMENT Primary key,
    Emp_name Nvarchar(50),
    Role_id int ,
	FOREIGN KEY (Role_id) REFERENCES _Role(ID)
);
-- sinh vien
CREATE Table Student(
	ID int AUTO_INCREMENT Primary key,
    Student_name Nvarchar(50),
    Sex bit,
    Phone Varchar(10),
    Email Text,
    Address Text
);

-- muon sach
CREATE TABLE Borrowing_books(
	ID int AUTO_INCREMENT Primary key,
    Employee_id int,	-- Nhan vien
    Student_id int,		-- Sinh vien
    Borrow_date date,	-- Ngay muon
	Return_date date,	-- Ngay tra
    FOREIGN KEY (Employee_id) REFERENCES Employee(ID),
    FOREIGN KEY (Student_id) REFERENCES Student(ID)
);

-- muon sach chi tiet
CREATE TABLE Borrowing_books_details(
	ID int AUTO_INCREMENT Primary key,
    Book_id int, 		-- ID sach
    Quantity int,		-- So luong
    Borrowing_id int,	-- ID muon sach
    Real_Return_date date,	-- ngay tra thuc te
    FOREIGN KEY (Book_id) REFERENCES Books(ID),
    FOREIGN KEY (Borrowing_id) REFERENCES Borrowing_books(ID)
);
SELECT * FROM Borrowing_books_details;
-- Insert dữ liệu cho bảng Authors
INSERT INTO Authors (Aut_name) VALUES
('Author 1'),
('Author 2'),
('Author 3'),
('Author 4'),
('Author 5'),
('Author 6');
Select * from Authors

-- Insert dữ liệu cho bảng Category
INSERT INTO Category (Cgr_name) VALUES
('Category 1'),
('Category 2'),
('Category 3'),
('Category 4'),
('Category 5'),
('Category 6');
Select * from Category;

-- Insert dữ liệu cho bảng Books
INSERT INTO Books (Title, Author_id, Category_id, Publication_year, Quantity_in_stock) VALUES
('Book 1', 1, 1, '2022-01-01', 10),
('Book 2', 2, 1, '2021-02-01', 15),
('Book 3', 1, 4, '2020-03-01', 20),
('Book 4', 3, 1, '2022-01-01', 10),
('Book 5', 4, 1, '2021-02-01', 15),
('Book 6', 5, 4, '2020-03-01', 20);
SELECT * FROM Books;

-- Insert dữ liệu cho bảng _Role
INSERT INTO _Role (Role_name) VALUES
('Role 1'),
('Role 2'),
('Role 3');
SELECT * FROM _Role;

-- Insert dữ liệu cho bảng Employee
INSERT INTO Employee (Emp_name, Role_id) VALUES
('Employee 1', 1),
('Employee 2', 2),
('Employee 3', 3),
('Employee 4', 1);
SELECT * FROM Employee;

-- Insert dữ liệu cho bảng Student
INSERT INTO Student (Student_name, Sex, Phone, Email, Address) VALUES
('Student 1', 1, '1234567890', 'student1@example.com', 'Address 1'),
('Student 2', 0, '9876543210', 'student2@example.com', 'Address 2'),
('Student 3', 1, '1112233444', 'student3@example.com', 'Address 3'),
('Student 4', 1, '1234567890', 'student4@example.com', 'Address 4'),
('Student 5', 0, '9876543210', 'student5@example.com', 'Address 5'),
('Student 6', 0, '1112233444', 'student6@example.com', 'Address 6');
SELECT * FROM Student;

-- Insert dữ liệu cho bảng Borrowing_books
INSERT INTO Borrowing_books (Employee_id, Student_id, Borrow_date, Return_date) VALUES
(1, 1, '2023-01-01', '2023-01-15'), -- 1
(1, 2, '2023-02-01', '2023-02-15'), -- 2
(1, 3, '2023-03-01', '2023-03-15'), -- 3
(1, 3, '2023-11-10', '2023-11-15'), -- 4
(1, 4, '2023-01-05', '2023-01-15'), -- 5
(4, 2, '2023-11-09', '2023-11-25'), -- 6
(4, 3, '2023-11-07', '2023-11-20'), -- 7
(4, 3, '2023-11-30', '2023-12-15'); -- 8
SELECT * FROM Borrowing_books;

-- Insert dữ liệu cho bảng Borrowing_books_details
INSERT INTO Borrowing_books_details (Book_id, Quantity, Borrowing_id, Real_Return_date) VALUES
(1, 2, 1, '2023-01-17'), -- 1
(2, 3, 2, '2023-02-17'), -- 2
(3, 1, 3, '2023-03-17'), -- 3
(4, 2, 4, '2023-11-17'), -- 4
(5, 3, 5, '2023-01-17'), -- 5
(6, 1, 6, '2023-11-25'), -- 6
(1, 1, 7, '2023-11-20'), -- 7
(1, 2, 8, '2023-12-15'); -- 8
SELECT * FROM Borrowing_books_details;


-- Select toàn bộ danh sách sinh viên có trong CSDL
SELECT * FROM Student;

-- Select toàn bộ phiếu mượn sách bao gồm Mã phiếu, ngày mượn, ngày hết hạn, tên sinh viên mượn sách, tổng số cuốn sách của phiếu.
SELECT 	bb.ID AS MaPhieu,
		bb.Borrow_date AS NgayMuon,
		bb.Return_date AS NgayHetHan,
		s.Student_name AS TenSinhVien,
		SUM(bbd.Quantity) AS TongSoCuonSach
FROM Borrowing_books bb
JOIN Student s ON bb.Student_id = s.ID
JOIN Borrowing_books_details bbd ON bb.ID = bbd.Borrowing_id
GROUP BY bb.ID, bb.Borrow_date, bb.Return_date, s.Student_name;

-- Sắp xếp danh sách theo thứ tự giảm dần dựa vào tổng số cuốn sách của mỗi đơn.
SELECT  bb.ID AS MaPhieu,
		bb.Borrow_date AS NgayMuon,
		bb.Return_date AS NgayHetHan,
		s.Student_name AS TenSinhVien,
		SUM(bbd.Quantity) AS TongSoCuonSach
FROM Borrowing_books bb
JOIN Student s ON bb.Student_id = s.ID
JOIN Borrowing_books_details bbd ON bb.ID = bbd.Borrowing_id
GROUP BY bb.ID, bb.Borrow_date, bb.Return_date, s.Student_name
ORDER BY TongSoCuonSach DESC;

-- Tìm  5 người mượn nhiều cuốn sách nhất.
SELECT 	s.Student_name AS TenSinhVien,
		SUM(bbd.Quantity) AS TongSoCuonSach
FROM Borrowing_books bb
JOIN Student s ON bb.Student_id = s.ID
JOIN Borrowing_books_details bbd ON bb.ID = bbd.Borrowing_id
GROUP BY s.Student_name
ORDER BY TongSoCuonSach DESC
LIMIT 5;
 
 
 -- Tìm 5 cuốn sách được mượn nhiều nhất.
SELECT 	b.Title AS TenSach,
		SUM(bbd.Quantity) AS TongSoLuotMuon
FROM Books b
JOIN Borrowing_books_details bbd ON b.ID = bbd.Book_id
GROUP BY b.Title
ORDER BY TongSoLuotMuon DESC
LIMIT 5;

-- Tìm người hay trả sách quá hạn nhiều nhất, nếu có 2 người có số lần quá hạn giống nhau thì select người có tổng thời gian quá hạn nhiều nhất.
SELECT 	s.Student_name AS TenSinhVien,
		COUNT(*) AS SoLanQuaHan,
		SUM(DATEDIFF(bb.Return_date, bb.Return_date)) AS TongThoiGianQuaHan
FROM Borrowing_books bb
JOIN Student s ON bb.Student_id = s.ID
WHERE bb.Return_date > bb.Return_date
GROUP BY s.Student_name
ORDER BY SoLanQuaHan DESC, TongThoiGianQuaHan DESC
LIMIT 1;

-- Tìm người thủ thư có lượt cho mượn sách nhiều nhất
SELECT  e.Emp_name AS TenThuThu,
		COUNT(*) AS SoLanChoMuon
FROM Borrowing_books bb
JOIN Employee e ON bb.Employee_id = e.ID
GROUP BY e.Emp_name
ORDER BY SoLanChoMuon DESC
LIMIT 1;

-- Tìm sinh viên nữ mượn sách nhiều nhất trong tháng 11/2023
SELECT 	s.Student_name AS TenSinhVien,
		COUNT(*) AS SoLanMuon
FROM Borrowing_books bb
JOIN Student s ON bb.Student_id = s.ID
WHERE s.Sex = 0 AND MONTH(bb.Borrow_date) = 11 AND YEAR(bb.Borrow_date) = 2023
GROUP BY s.Student_name
ORDER BY SoLanMuon DESC
LIMIT 1;

