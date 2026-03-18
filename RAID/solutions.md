# Solution & Calculation Guide

This document provides the solutions, mathematical breakdowns, and detailed explanations for the RAID Storage Systems worksheet.

---

## Part 1: Scenario Analysis - Explanations

**Q1: C (RAID 0)**
* **Explanation:** RAID 0 utilizes **Striping**, which slices data into blocks and writes them across all drives simultaneously. Because the drive heads work in parallel, the read/write speed scales with the number of drives. However, it provides **zero fault tolerance**; if one drive fails, the entire array is lost. In this scenario, the researcher prioritize speed for temporary data, making RAID 0 the most efficient choice.

**Q2: C (RAID 1)**
* **Explanation:** RAID 1 is defined by **Mirroring**. For a small business with only two drives, this is the most reliable setup. Every write operation is duplicated. While this reduces usable capacity by 50%, it ensures the business stays online even if one physical disk suffers a mechanical failure, as the other drive contains a perfect, real-time copy.

**Q3: B (RAID 5)**
* **Explanation:** RAID 5 is a "Balanced" configuration using **Distributed Parity**.
    * **Efficiency:** In a 5-drive setup, the system behaves as if you have 4 drives for storage and 1 for protection ($n-1$). This results in 80% usable space.
    * **Fault Tolerance:** It can survive the loss of exactly one drive. The parity data allows the controller to mathematically "rebuild" the missing data from a failed drive onto a new replacement disk.

---

## Part 2: Calculation Breakdown (Using 12TB Drives)

**Q4: B (36TB)**
* **Calculation:** $(n - 1) \times C \rightarrow (4 - 1) \times 12 = 3 \times 12 = 36$.
* **Explanation:** Even though parity is spread across all disks in RAID 5, the total space "lost" to redundancy is always equal to exactly one drive's capacity.

**Q5: C (24TB)**
* **Calculation:** $(n / 2) \times C \rightarrow (4 / 2) \times 12 = 2 \times 12 = 24$.
* **Explanation:** RAID 10 (or RAID 1+0) mirrors the drives first and then stripes them. Because every drive has a "twin" containing the exact same data, your usable space is always 50% of your total raw disk space.

**Q6: B (2)**
* **Explanation:** RAID 6 uses **Dual Parity**. It calculates two different sets of parity information for every block of data. This allows the array to stay functional even during a "double-fault" scenario (two drives failing at once), providing extra security during long rebuild processes.

**Q7: A (36TB)**
* **Calculation:** $n \times C \rightarrow 3 \times 12 = 36$.
* **Explanation:** RAID 0 has no overhead for parity or mirroring. It simply combines the capacity of all drives together into one large, high-performance volume.

---


## Part 3: Using the Synology RAID Calculator
RAID calculators are essential tools for planning storage systems. They help you visualize how different drive sizes and RAID levels impact your usable capacity and performance.


The [Synology RAID Calculator](https://www.synology.com/en-us/support/RAID_calculator) is a visual industry tool used to estimate storage space and visualize how different disk configurations affect your array.

### **How to Use the Synology Calculator:**
1.  **Drag and Drop Drives:** From the available list of drive sizes (e.g., 4TB, 8TB, 12TB), drag the specific drives you want into the empty slots of the virtual NAS (Network Attached Storage) unit.
2.  **Choose Your RAID Level:** Below the drives, click the button for the RAID level you want to test (RAID 0, 1, 5, 6, or 10).
3.  **Analyze the Color-Coded Bar:** The calculator will display a horizontal bar showing exactly how your storage is being used:
    * **Blue (Used Space):** This is your actual usable capacity for files.
    * **Red (Protection):** This is the space "lost" to parity or mirroring to ensure your data stays safe.
    * **Orange (Unused Space):** This appears if you mix drive sizes. Most RAID levels (except SHR) cannot use the extra space on a larger drive if it is paired with smaller drives.
4.  **Check Fault Tolerance:** Below the capacity totals, the tool will explicitly state how many drives can fail (e.g., "1-drive fault tolerance") before data loss occurs.
