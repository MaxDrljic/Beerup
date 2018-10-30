<?php

namespace App\Entity;

use Symfony\Component\Validator\Constraints as Assert;
use ApiPlatform\Core\Annotation\ApiResource;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;

/**
 * Grab a beer.
 *
 * @ORM\Entity
 * @ApiResource
 */
class Beer
{
    /**
     * @var int The id of this beer.
     *
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @var string The name of the beer.
     *
     * @ORM\Column(type="string")
     * @Assert\Length(min=2, max=20)
     * @Assert\NotBlank
     */
    public $name;

    /**
     * @var string|null The description of the beer (or null if doesn't have one).
     *
     * @ORM\Column(type="text", nullable=true)
     */
    public $description;

    /**
     * @var string The abv of this beer.
     *
     * @ORM\Column(type="string")
     * @Assert\NotNull
     */
    public $abv;

    /**
     * @var string|null The ibu of this beer (or null if doesn't have one).
     *
     * @ORM\Column(type="string", nullable=true)
     */
    public $ibu;

    /**
     * @var string|null The image url of this beer (or null if doesn't have one).
     *
     * @ORM\Column(type="string", nullable=true)
     */
    public $imageUrl;

    /**
     * @var Favorite[] Favorites for beer.
     *
     * @ORM\OneToOne(targetEntity="Favorite")
     */
    public $favorites;
    
    public function __construct() {
        $this->favorites = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }
}
