use clap::Parser;
use rcrawler::{config, crawler::engine::CrawlEngine, output::html, output::json};
use std::path::PathBuf;

#[derive(Parser, Debug)]
#[command(name = "rcrawler")]
#[command(about = "High-performance web crawler in Rust", long_about = None)]
struct Cli {
    /// URL to crawl
    url: String,

    /// Restrict to this domain
    #[arg(long)]
    domain: Option<String>,

    /// Number of concurrent workers
    #[arg(short, long)]
    workers: Option<usize>,

    /// Maximum crawl depth
    #[arg(short = 'd', long)]
    depth: Option<usize>,

    /// Rate limit (requests per second)
    #[arg(short, long)]
    rate: Option<f64>,

    /// Profile (fast, deep, gentle)
    #[arg(short, long)]
    profile: Option<String>,

    /// Output directory
    #[arg(short, long)]
    output: Option<PathBuf>,

    /// Use sitemap.xml
    #[arg(short, long)]
    sitemap: Option<bool>,

    /// Output format (json, markdown, default)
    #[arg(short, long, default_value = "default")]
    format: String,

    /// Enable debug logging
    #[arg(long)]
    debug: bool,
}

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    let cli = Cli::parse();

    // Build configuration
    let config = config::build_config(
        cli.url,
        cli.domain,
        cli.workers,
        cli.depth,
        cli.rate,
        cli.profile.as_deref(),
        cli.output,
        cli.sitemap,
    );

    println!("Starting crawl of: {}", config.base_url);
    println!("Config: {} workers, depth {}", config.max_workers, config.max_depth);

    // Create engine and crawl
    let engine = CrawlEngine::new(config.clone())?;
    let results = engine.crawl().await?;

    // Output results
    let json_path = config.output_dir.join("results.json");
    json::write_json(&results, &json_path)?;

    let html_path = config.output_dir.join("index.html");
    html::write_html_report(&results, &html_path)?;

    println!("\nCrawl complete!");
    println!("Pages crawled: {}", results.stats.pages_crawled);
    println!("Duration: {:?}ms", results.stats.duration);
    println!("Results saved to: {}", json_path.display());
    println!("HTML report: {}", html_path.display());

    Ok(())
}
