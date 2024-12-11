<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Disease extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'description',
        'photo',
        'symptoms',
        'treatment',
        'cause',
        'prevention',
        'contagious',
        'risk_factors',
        'related_diseases',
        'references',
    ];

    protected $casts = [
        'contagious' => 'boolean',
    ];
    
    /**
     * Relationships
     */
    public function scanHistories()
    {
        return $this->hasMany(ScanHistory::class);
    }
}
