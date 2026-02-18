export default function HomePage() {
  return (
    <main style={{ 
      padding: "60px 20px", 
      fontFamily: "Arial, sans-serif",
      maxWidth: "1100px",
      margin: "0 auto"
    }}>
      
      <header style={{ marginBottom: "40px" }}>
        <h1 style={{ fontSize: "42px", marginBottom: "10px" }}>
          Dean & Camper, P.A.
        </h1>
        <p style={{ fontSize: "20px", color: "#555" }}>
          Personal Injury Lawyers Serving Florida and Alabama
        </p>
      </header>

      <section>
        <h2 style={{ fontSize: "28px", marginBottom: "20px" }}>
          Our Offices
        </h2>

        <ul style={{ 
          listStyle: "none", 
          padding: 0,
          display: "grid",
          gridTemplateColumns: "repeat(auto-fit, minmax(220px, 1fr))",
          gap: "20px"
        }}>
          {[
            "Pensacola",
            "Fort Walton Beach",
            "Crestview",
            "Destin / Miramar Beach",
            "Mobile"
          ].map((city) => (
            <li
              key={city}
              style={{
                padding: "20px",
                border: "1px solid #ddd",
                borderRadius: "8px",
                background: "#f9f9f9"
              }}
            >
              {city}
            </li>
          ))}
        </ul>
      </section>

    </main>
  );
}
