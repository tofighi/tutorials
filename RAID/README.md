RAID Storage Systems & Calculations


---

## 1. Introduction to RAID
Based on the [RAID Storage Systems](https://docs.google.com/presentation/d/1c-nqA5UhLp8asV_0q0L42EFM6eJUgM2Or223KZyathM/edit?slide=id.p#slide=id.p) presentation, **RAID** (Redundant Array of Independent Disks) is a technology that combines multiple physical drives into a single logical unit. The primary goals are to improve **Performance** (speed) and/or **Redundancy** (data protection).

### Key Concepts:
* **Striping:** Spreading data across multiple drives to increase speed.
* **Mirroring:** Copying data onto multiple drives for safety.
* **Parity:** Using mathematical calculations to reconstruct data if a drive fails.

---

## 2. Calculation Tutorial & Formulas
To calculate the **Usable Capacity** of a RAID array, you must account for the "overhead" required for redundancy. Use the following formulas where $n$ is the number of drives and $C$ is the capacity of the smallest drive.

| RAID Level | Description | Usable Capacity Formula |
| :--- | :--- | :--- |
| **RAID 0** | Striping only. No redundancy. | $n \times C$ |
| **RAID 1** | Mirroring. Data is duplicated. | $C$ (Capacity of 1 drive) |
| **RAID 5** | Striping with distributed parity. | $(n - 1) \times C$ |
| **RAID 6** | Striping with double parity. | $(n - 2) \times C$ |
| **RAID 10** | A stripe of mirrors (RAID 1 + 0). | $(n / 2) \times C$ |

---

## 3. Scenario Challenge (Multiple Choice)
*Select the most appropriate RAID level for each client.*

**Q1. The Video Editor:** A user needs maximum performance for **Video Production** scratch files. They have an external backup and aren't worried about drive failure.
* A) RAID 1
* B) RAID 5
* C) RAID 0
* D) RAID 6

**Q2. The Small Clinic:** A doctor needs to store **Medical Imaging** (X-rays) securely. They only have two drives. If one fails, they cannot lose any data.
* A) RAID 0
* B) RAID 5
* C) RAID 1
* D) RAID 10

**Q3. The Balanced Server:** A company has five 10TB drives. They want good performance and must be able to survive exactly **one** drive failure while keeping 80% of their total raw space usable.
* A) RAID 10
* B) RAID 5
* C) RAID 6
* D) RAID 1

---

## 4. Capacity Calculation Exercise
*Assume you are using **12TB hard drives** for all questions below.*

**Q4. You have a 4-drive RAID 5 array. What is the total usable capacity?**
* A) 48TB
* B) 36TB
* C) 24TB
* D) 12TB

**Q5. You have a 4-drive RAID 10 array. What is the total usable capacity?**
* A) 48TB
* B) 36TB
* C) 24TB
* D) 12TB

**Q6. You have a 6-drive RAID 6 array. How many drive failures can this system survive?**
* A) 1
* B) 2
* C) 3
* D) 0

**Q7. If you use RAID 0 with 3 drives, what is the usable capacity?**
* A) 36TB
* B) 24TB
* C) 12TB
* D) 0TB
