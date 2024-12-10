<?php

namespace Database\Seeders;

use App\Models\Disease;
use Illuminate\Database\Seeder;

class DiseaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $diseases = [
            [
                'name' => 'Blackhead',
                'description' => 'A small black bump caused by clogged hair follicles.',
                'photo' => 'images/blackhead.jpg',
                'symptoms' => 'Small dark spots on the skin, commonly on the nose.',
                'treatment' => 'Gentle skin cleansing, pore strips, and salicylic acid.',
                'cause' => 'Excess oil and dead skin cells clogging pores.',
                'prevention' => 'Regular cleansing, avoid greasy skincare products.',
                'contagious' => false,
                'risk_factors' => 'Oily skin, hormonal changes.',
                'related_diseases' => 'Acne.',
                'references' => 'https://www.healthline.com/health/blackheads',
            ],
            [
                'name' => 'Eczema',
                'description' => 'A skin condition that causes inflammation, itchiness, and redness.',
                'photo' => 'images/eczema.jpg',
                'symptoms' => 'Dry, itchy, and inflamed skin patches.',
                'treatment' => 'Moisturizers, corticosteroids, and antihistamines.',
                'cause' => 'Immune system reaction, genetics.',
                'prevention' => 'Avoid harsh soaps, keep skin hydrated.',
                'contagious' => false,
                'risk_factors' => 'Family history of eczema, allergies.',
                'related_diseases' => 'Dermatitis.',
                'references' => 'https://www.mayoclinic.org/diseases-conditions/eczema',
            ],
            [
                'name' => 'Dark Spots',
                'description' => 'Dark patches on the skin caused by sun exposure or aging.',
                'photo' => 'images/dark_spots.jpg',
                'symptoms' => 'Flat, dark patches on the face or hands.',
                'treatment' => 'Skin-lightening creams, laser treatments.',
                'cause' => 'Sun exposure, hormonal changes.',
                'prevention' => 'Use sunscreen, avoid prolonged sun exposure.',
                'contagious' => false,
                'risk_factors' => 'Light skin tone, overexposure to sunlight.',
                'related_diseases' => 'Melasma.',
                'references' => 'https://www.aad.org/public/cosmetic/sun-spots',
            ],
            [
                'name' => 'Herpes',
                'description' => 'A viral skin infection causing painful blisters.',
                'photo' => 'images/herpes.jpg',
                'symptoms' => 'Painful blisters or sores on the skin.',
                'treatment' => 'Antiviral medication, pain relief ointments.',
                'cause' => 'Infection by the herpes simplex virus (HSV).',
                'prevention' => 'Avoid direct contact with an infected person.',
                'contagious' => true,
                'risk_factors' => 'Weakened immune system, direct contact.',
                'related_diseases' => 'Shingles.',
                'references' => 'https://www.cdc.gov/std/herpes',
            ],
            [
                'name' => 'Acne',
                'description' => 'A skin condition causing pimples, blackheads, and oily skin.',
                'photo' => 'images/acne.jpg',
                'symptoms' => 'Pimples, blackheads, and red inflamed spots.',
                'treatment' => 'Topical treatments, retinoids, and antibiotics.',
                'cause' => 'Excess oil production, clogged pores, and bacteria.',
                'prevention' => 'Cleanse skin regularly, avoid touching the face.',
                'contagious' => false,
                'risk_factors' => 'Teenage years, hormonal fluctuations.',
                'related_diseases' => 'Rosacea.',
                'references' => 'https://www.aad.org/public/diseases/acne',
            ],
            [
                'name' => 'Milia',
                'description' => 'Small, white bumps that usually appear on the face.',
                'photo' => 'images/milia.jpg',
                'symptoms' => 'Tiny white or yellow bumps, typically under the eyes.',
                'treatment' => 'Gentle exfoliation or dermatologist procedures.',
                'cause' => 'Keratin trapped under the skin.',
                'prevention' => 'Maintain a good skincare routine, avoid heavy creams.',
                'contagious' => false,
                'risk_factors' => 'Sensitive skin.',
                'related_diseases' => 'Keratocyst.',
                'references' => 'https://www.medicalnewstoday.com/articles/milia',
            ],
            [
                'name' => 'Normal',
                'description' => 'Healthy skin without any visible issues.',
                'photo' => 'images/normal.jpg',
                'symptoms' => 'Smooth, clear, and balanced skin.',
                'treatment' => 'Daily skincare routine, moisturizer, and sunscreen.',
                'cause' => 'Proper skin health and care.',
                'prevention' => 'Regular hydration and protection from environmental factors.',
                'contagious' => false,
                'risk_factors' => 'None.',
                'related_diseases' => null,
                'references' => 'https://www.healthline.com/health/normal-skin',
            ],
            [
                'name' => 'Pityriasis Versicolor (Tinea Versicolor)',
                'description' => 'A fungal infection causing discolored patches of skin.',
                'photo' => 'images/tinea_versicolor.jpg',
                'symptoms' => 'White or light brown patches on the skin.',
                'treatment' => 'Antifungal creams, shampoos, or oral medication.',
                'cause' => 'Fungal infection by Malassezia.',
                'prevention' => 'Keep skin dry, avoid excessive sweating.',
                'contagious' => false,
                'risk_factors' => 'Hot and humid climates, oily skin.',
                'related_diseases' => 'Seborrheic dermatitis.',
                'references' => 'https://www.dermnetnz.org/topics/tinea-versicolor',
            ],
        ];

        foreach ($diseases as $disease) {
            Disease::create($disease);
        }
    }
}
