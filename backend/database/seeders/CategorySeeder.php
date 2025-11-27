<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Category::create([
            'name' => 'Electronics',
            'description' => 'Electronic devices and accessories',
            'is_active' => true,
        ]);

        Category::create([
            'name' => 'Clothing',
            'description' => 'Apparel and fashion items',
            'is_active' => true,
        ]);

        Category::create([
            'name' => 'Home & Garden',
            'description' => 'Home improvement and garden supplies',
            'is_active' => true,
        ]);
    }
}