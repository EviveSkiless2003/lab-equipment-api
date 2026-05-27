# Lab Equipment Management & Marketplace API

A robust, production-ready backend service built with Ruby on Rails designed to streamline laboratory asset tracking, manage equipment maintenance history, and enforce strict structural business rules. This API handles data validation, relationship dependencies, and custom optimization strategies to ensure high-performance data retrieval.

---

## Core Project Objectives
* **Asset Tracking:** Track every piece of equipment and its associated category.
* **Status Monitoring:** Monitor the exact lifecycle status of each item (`available`, `in_use`, `maintenance`).
* **Maintenance Logs:** Keep a comprehensive, chronological history of all service work performed on equipment.
* **Data Integrity:** Prevent nonsense data from entering the system through rigid validation rules.
* **Business Rule Enforcement:** Enforce real-world constraints that keep the database trustworthy and sound.

---

## System Specifications & Architecture

### Tech Stack
* **Framework:** Ruby on Rails 7.1.6 (API-only mode)
* **Language:** Ruby 3.2.x / 3.3.x
* **Database:** SQLite3 (Development) / Enterprise-ready relational structure

### Schema & Constraints
* **Composite Indexes:** Optimized querying on maintenance logs via a composite index tracking `[:equipment_id, :performed_at]`.
* **Database Guards:** `unique` constraints enforced on category names and equipment serial numbers.
* **Cascade Deletion:** Destroying an equipment profile automatically cascades to delete its maintenance log history (`dependent: :destroy`).
* **Referential Integrity:** Parent categories are protected from deletion if they still contain active equipment (`dependent: :restrict_with_error`).

---

## Getting Started & Installation

Follow these steps to spin up the API environment locally:

### 1. Clone the Repository
```bash
git clone [https://github.com/EviveSkiless2003/lab-equipment-api.git](https://github.com/EviveSkiless2003/lab-equipment-api.git)
cd lab-equipment-api
