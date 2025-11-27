<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Product;
use App\Models\Category;

class DummyProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Get existing categories or create some if none exist
        $categories = Category::all();
        if ($categories->isEmpty()) {
            $electronics = Category::create([
                'name' => 'Electronics',
                'description' => 'Electronic devices and accessories',
                'is_active' => true,
            ]);
            
            $clothing = Category::create([
                'name' => 'Clothing',
                'description' => 'Apparel and fashion items',
                'is_active' => true,
            ]);
            
            $home = Category::create([
                'name' => 'Home & Garden',
                'description' => 'Home improvement and garden supplies',
                'is_active' => true,
            ]);
            
            $categories = Category::all();
        }
        
        $categoryId1 = $categories->first()->id;
        $categoryId2 = $categories->count() > 1 ? $categories->skip(1)->first()->id : $categoryId1;
        $categoryId3 = $categories->count() > 2 ? $categories->skip(2)->first()->id : $categoryId1;

        // Create dummy products
        Product::create([
            'name' => 'Wireless Bluetooth Headphones',
            'sku' => 'WBH001',
            'description' => 'High-quality wireless headphones with noise cancellation',
            'price' => 89.99,
            'cost_price' => 45.00,
            'stock_quantity' => 25,
            'category_id' => $categoryId1,
            'is_active' => true,
        ]);

        Product::create([
            'name' => 'Smart Fitness Watch',
            'sku' => 'SFW002',
            'description' => 'Track your fitness goals with this smart watch',
            'price' => 129.99,
            'cost_price' => 75.00,
            'stock_quantity' => 15,
            'category_id' => $categoryId1,
            'is_active' => true,
        ]);

        Product::create([
            'name' => 'Coffee Maker Deluxe',
            'sku' => 'CMD003',
            'description' => 'Premium coffee maker with programmable features',
            'price' => 79.99,
            'cost_price' => 40.00,
            'stock_quantity' => 10,
            'category_id' => $categoryId3,
            'is_active' => true,
        ]);

        Product::create([
            'name' => 'Cotton T-Shirt',
            'sku' => 'CTS004',
            'description' => 'Comfortable 100% cotton t-shirt',
            'price' => 19.99,
            'cost_price' => 8.00,
            'stock_quantity' => 50,
            'category_id' => $categoryId2,
            'is_active' => true,
        ]);

        Product::create([
            'name' => 'Designer Jeans',
            'sku' => 'DJN005',
            'description' => 'Stylish designer jeans with perfect fit',
            'price' => 59.99,
            'cost_price' => 25.00,
            'stock_quantity' => 20,
            'category_id' => $categoryId2,
            'is_active' => true,
        ]);

        Product::create([
            'name' => 'Gaming Mouse',
            'sku' => 'GM006',
            'description' => 'High-precision gaming mouse with RGB lighting',
            'price' => 49.99,
            'cost_price' => 20.00,
            'stock_quantity' => 30,
            'category_id' => $categoryId1,
            'is_active' => true,
        ]);

        Product::create([
            'name' => 'Yoga Mat',
            'sku' => 'YM007',
            'description' => 'Non-slip yoga mat for all your fitness needs',
            'price' => 29.99,
            'cost_price' => 12.00,
            'stock_quantity' => 35,
            'category_id' => $categoryId3,
            'is_active' => true,
        ]);

        Product::create([
            'name' => 'Bluetooth Speaker',
            'sku' => 'BS008',
            'description' => 'Portable waterproof Bluetooth speaker',
            'price' => 39.99,
            'cost_price' => 18.00,
            'stock_quantity' => 18,
            'category_id' => $categoryId1,
            'is_active' => true,
        ]);
    }
}