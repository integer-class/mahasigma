<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Disease;

class DiseaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $diseases = [
            [
                'name' => 'Acne',
                'description' => 'A common skin condition that causes pimples and blackheads.',
                'symptoms' => 'Redness, swelling, pimples, blackheads.',
                'treatment' => 'Topical creams, antibiotics, retinoids.',
            ],
            [
                'name' => 'Actinic Keratosis',
                'description' => 'A rough, scaly patch on the skin caused by years of sun exposure.',
                'symptoms' => 'Rough texture, redness, itching, burning.',
                'treatment' => 'Cryotherapy, topical medications, laser therapy.',
            ],
            [
                'name' => 'Basal Cell Carcinoma',
                'description' => 'A type of skin cancer that often appears as a waxy bump.',
                'symptoms' => 'A pearly bump, flat lesion, open sore.',
                'treatment' => 'Surgical excision, radiation therapy, topical treatments.',
            ],
            [            
                'name' => 'Eczema',
                'description' => 'A condition that makes the skin red, itchy, and inflamed.',
                'symptoms' => 'Itching, redness, swelling, dry skin.',
                'treatment' => 'Moisturizers, corticosteroid creams, antihistamines.',
            ],
            [
                'name' => 'Normal',
                'description' => 'Healthy skin without signs of disease or abnormality.',
                'symptoms' => 'No redness, swelling, bumps, or irritation.',
                'treatment' => 'Maintain good skin hygiene, use sunscreen, and moisturize regularly.',
            ],
            [
                'name' => 'Rosacea',
                'description' => 'A chronic skin condition causing redness and visible blood vessels in the face.',
                'symptoms' => 'Facial redness, swollen bumps, sensitive skin.',
                'treatment' => 'Topical treatments, oral antibiotics, laser therapy.',
            ],
        ];

        foreach ($diseases as $disease) {
            Disease::create($disease);
        }
    }
}