<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Product;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Get the first category for all products
        $categoryId = \DB::table('categories')->first()->id ?? 1;

        Product::create([
            'name' => 'Apple iPhone 15',
            'sku' => 'IPH15',
            'description' => 'Latest Apple iPhone 15 with 256GB storage',
            'price' => 999.99,
            'cost_price' => 800.00,
            'stock_quantity' => 15,
            'category_id' => $categoryId,
            'is_active' => true,
        ]);

        Product::create([
            'name' => 'Samsung Galaxy S24',
            'sku' => 'S24',
            'description' => 'Samsung Galaxy S24 with 512GB storage',
            'price' => 899.99,
            'cost_price' => 700.00,
            'stock_quantity' => 10,
            'category_id' => $categoryId,
            'is_active' => true,
        ]);

        Product::create([
            'name' => 'MacBook Pro 16"',
            'sku' => 'MBP16',
            'description' => 'Apple MacBook Pro 16 inch with M2 chip',
            'price' => 2399.99,
            'cost_price' => 2000.00,
            'stock_quantity' => 5,
            'category_id' => $categoryId,
            'is_active' => true,
        ]);

        Product::create([
            'name' => 'Nike Air Max',
            'sku' => 'NAM24',
            'description' => 'Nike Air Max 2024 Black Edition',
            'price' => 129.99,
            'cost_price' => 80.00,
            'stock_quantity' => 30,
            'category_id' => $categoryId + 1, // Clothing category
            'is_active' => true,
        ]);

        Product::create([
            'name' => 'Levi\'s Jeans',
            'sku' => 'LV501',
            'description' => 'Levi\'s 501 Black Jeans Size 32',
            'price' => 79.99,
            'cost_price' => 45.00,
            'stock_quantity' => 20,
            'category_id' => $categoryId + 1, // Clothing category
            'is_active' => true,
        ]);
    }
}