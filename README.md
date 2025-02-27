# <span style="color: #010839;">Download Files with Directory Structure Script</span>

<span style="color: #6cd4ff; font-size: 1.2em;">Automate file downloads while preserving your URL-based directory structure.</span>

---

## <span style="color: #6f0992;">Color Palette</span>

**Primary Colors:**

- **Deep Navy** <span style="color: #010839;">`#010839`</span> – Authority, trust, and professionalism.
- **Brand Purple** <span style="color: #6f0992;">`#6f0992`</span> – Distinct identity, energy, and innovation.
- **Military Red** <span style="color: #bb0000;">`#bb0000`</span> – Bold, urgency-driven elements.
- **White** <span style="color: #ffffff; background: #ffffff; border: 1px solid #ccc;">`#ffffff`</span> – Clean, high-contrast readability.

**Secondary Colors:**

- **Vibrant Orange** <span style="color: #ffa500;">`#ffa500`</span> – Energy, enthusiasm, and secondary CTAs.
- **Light Blue** <span style="color: #6cd4ff;">`#6cd4ff`</span> – Tech-forward and modern military feel.
- **Dark Green** <span style="color: #1f7b19;">`#1f7b19`</span> – Stability, support, and veteran empowerment.

**Neutral Colors:**

- **Light Gray / Off-White** <span style="color: #e5e5e5;">`#e5e5e5`</span> / <span style="color: #f5f5f5;">`#f5f5f5`</span> – Soft contrast for sections.
- **Dark Gray** <span style="color: #3a3a3a;">`#3a3a3a`</span> – Text contrast for readability.

---

## <span style="color: #6f0992;">Features</span>

- **Multiple Input Options:**
  - **Command-Line Arguments:** Supply one or more URLs directly when running the script.
  - **URL List File:** If no URLs are provided as arguments, the script reads from a file named <code>urls.txt</code> (one URL per line).

- **Automatic Directory Creation:**  
  The script creates directories based on the URL path after the domain.  
  For example, the URL  
  <code>https://unpkg.com/swiper/swiper-bundle.min.css</code>  
  creates a local directory <code>swiper/</code> and saves the file as <code>swiper-bundle.min.css</code>.

- **Skip Existing Files:**  
  If a file already exists locally, the script skips downloading it.

---

## <span style="color: #6f0992;">How It Works</span>

1. **Input Processing:**
   - **Command-Line Arguments:**  
     If URLs are provided when invoking the script, those URLs are processed.
   - **URL List File:**  
     If no arguments are provided, the script checks for a file named <code>urls.txt</code> and reads URLs from it.

2. **Removing the Protocol and Extracting the Path:**
   - The script removes <code>http://</code> or <code>https://</code> from each URL.
   - It then extracts the file path after the domain. For example:
     - <code>https://unpkg.com/swiper/swiper-bundle.min.css</code> becomes <code>swiper/swiper-bundle.min.css</code>.
     - <code>https://cdn.userway.org/widget.js</code> becomes <code>widget.js</code> (saved directly in the current directory).

3. **Directory Creation:**
   - If the extracted path contains directories, the script creates them using <code>mkdir -p</code>.

4. **Downloading Files:**
   - The script uses <code>curl</code> with the <code>-L</code> flag to download each file.
   - If the file already exists locally, it is skipped.

---

## <span style="color: #6f0992;">Usage Options</span>

### <span style="color: #1f7b19;">Option 1: Using Command-Line Arguments</span>

Pass one or more URLs directly when running the script:

```bash
./download_files_interactive.sh https://unpkg.com/swiper/swiper-bundle.min.css https://cdn.userway.org/widget.js

