import mysql.connector
import random
from datetime import date, timedelta

# CONNECT TO MYSQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",   # <-- change if needed
    database="UniversityDB"
)

cursor = conn.cursor()

# ----------------- TEACHERS -----------------
print("Teachers toevoegen...")
for i in range(1, 121):
    cursor.execute("""
    INSERT INTO Teachers (First_name, Last_name, Email, Phone_Number, Specialization, Salery, Accepted_Date)
    VALUES (%s, %s, %s, %s, %s, %s, %s)
    """, (
        f"Teacher{i}",
        f"Lastname{i}",
        f"teacher{i}@uni.edu",
        f"0612345{i}",
        random.choice(["Math", "Physics", "Biology", "IT", "Economics"]),
        random.randint(30000, 70000),
        date.today() - timedelta(days=random.randint(500, 4000))
    ))

print("Done! 120 Teachers toegevoegd")

# ----------------- STUDENTS -----------------
print("Students toevoegen...")
for i in range(1, 121):
    cursor.execute("""
    INSERT INTO Students (First_Name, Last_Name, Date_Of_Birth, Student_Number)
    VALUES (%s, %s, %s, %s)
    """, (
        f"Student{i}",
        f"Surname{i}",
        date(2000, 1, 1) + timedelta(days=random.randint(0, 5000)),
        f"S2025{i:03}"
    ))

print("Done! 120 Students toegevoegd")

# ----------------- SUBJECTS -----------------
print("Subjects toevoegen...")
for i in range(1, 102):
    cursor.execute("""
    INSERT INTO Subjects (Subject_Name, Subject_Code, Details, Study_Points, Period, Teacher_ID)
    VALUES (%s, %s, %s, %s, %s, %s)
    """, (
        f"Subject{i}",
        f"SUB{i:03}",
        "Auto generated subject",
        random.randint(2, 6),
        random.randint(1, 4),
        random.randint(1, 120)
    ))

print("Done! 101 Subjects toegevoegd")

# ----------------- ENROLLMENTS -----------------
print("Enrollments toevoegen...")
for _ in range(371):
    cursor.execute("""
    INSERT INTO Enrollments (student_ID, Subjects_ID, Enrollment_Date, Grade, E_status)
    VALUES (%s, %s, %s, %s, %s)
    """, (
        random.randint(1, 120),
        random.randint(1, 101),
        date.today() - timedelta(days=random.randint(1, 200)),
        None,
        "Active"
    ))

print("Done! 371 Enrollments toegevoegd")

# SAVE CHANGES
conn.commit()
cursor.close()
conn.close()

print("\n✅ Done! Alle data succesvol toegevoegd!")
